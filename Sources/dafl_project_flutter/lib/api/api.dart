import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:developer' as dev;
import '../exceptions/api_exception.dart';
import 'track.dart';

class Api {
  //from dashboard
  final _clientId = '7ceb49d874b9404492246027e4d68cf8';
  final _clientSecret = '98f9cb960bf54ebbb9ad306e7ff919cb';

  //for web api
  get redirectUri => 'https://daflmusic.000webhostapp.com/callback/';
  final _scopes =
      'user-read-playback-state user-read-currently-playing user-read-recently-played playlist-modify-public';
  late String _state;
  dynamic _codeVerifier;
  dynamic _codeChallenge;
  late String _encodedLogs;
  final _tokenType = 'Bearer ';
  late http.Response _response; //use _setResponse() as kind of a private setter
  final _playlistName = "Dafl's discovery";

  //final _playlistName = 'daflmusic';

  //from web api
  String? _code;
  int? _expiresIn;
  String? _refreshToken;
  String? _accessToken; //use _getAccessToken() as kind of a private getter
  String? _idUser; //use _getIdUser() as kind of a private getter

  //other
  final _client = http.Client();
  late Uri _urlAuthorize;

  get urlAuthorize => _urlAuthorize;
  DateTime? _tokenEnd;

  Api() {
    _state = _generateRandomString(16);
    _codeVerifier = _generateRandomString(_generateRandomInt(43, 128));
    _codeChallenge = _generateCodeChallenge();
    _encodedLogs = base64.encode(utf8.encode("$_clientId:$_clientSecret"));
    _urlAuthorize = Uri.https('accounts.spotify.com', 'authorize', {
      'client_id': _clientId,
      'response_type': 'code',
      'redirect_uri': redirectUri,
      'state': _state,
      'scope': _scopes,
      'show_dialog': 'false',
      'code_challenge_method': 'S256',
      'code_challenge': _codeChallenge
    });
  }

  //PKCE generations

  _generateRandomInt(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  _generateRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
  }

  _generateCodeChallenge() {
    return base64Encode(sha256.convert(utf8.encode(_codeVerifier)).bytes)
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', '');
  }

  //session management

  requestUserAuthorization(Uri url) async {
    if (url.queryParameters['state'] != _state.toString()) {
      throw ApiException('state');
    }
    _code = url.queryParameters['code'];
    await _requestAccessToken();
  }

  _requestAccessToken() async {
    var urlToken = Uri.https('accounts.spotify.com', 'api/token', {
      'code': _code,
      'redirect_uri': redirectUri,
      'grant_type': 'authorization_code',
      'client_id': _clientId,
      'code_verifier': _codeVerifier
    });
    _setResponse(await _client.post(urlToken, headers: <String, String>{
      'Authorization': 'Basic $_encodedLogs',
      'Content-Type': 'application/x-www-form-urlencoded'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    _accessToken = decodedResponse['access_token'];
    _expiresIn = decodedResponse['expires_in'];
    _tokenEnd = DateTime.now().add(Duration(seconds: _expiresIn!));
    _refreshToken = decodedResponse['refresh_token'];
  }

  //handle 401 status code (bad or expired token)
  Future<String?> _getAccessToken() async {
    await _tokenValidity();
    return _accessToken;
  }

  _tokenValidity() async {
    if (DateTime.now().isAfter(_tokenEnd!)) {
      await _getRefreshedAccessToken();
    }
  }

  _setResponse(value) {
    int sc = value.statusCode;
    if (sc >= 300) {
      throw ApiException(sc);
    }
    _response = value;
  }

  _getRefreshedAccessToken() async {
    var urlToken = Uri.https('accounts.spotify.com', 'api/token', {
      'grant_type': 'refresh_token',
      'refresh_token': _refreshToken,
      'client_id': _clientId
    });
    _setResponse(await _client.post(urlToken, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    _accessToken = decodedResponse['access_token'];
    _expiresIn = decodedResponse['expires_in'];
    _tokenEnd = DateTime.now().add(Duration(seconds: _expiresIn!));
  }

  //functional methods

  Future<String> getCurrentlyPlayingTrack() async {
    var url = Uri.https('api.spotify.com', 'v1/me/player/currently-playing');
    var token = await _getAccessToken();
    var response = await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 204) {
      return getRecentlyPlayedTrack();
    }
    var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    return decodedResponse['item']['id'];
  }

  Future<String> getRecentlyPlayedTrack() async {
    var url = Uri.https(
        'api.spotify.com', 'v1/me/player/recently-played', {'limit': '1'});
    var token = await _getAccessToken();
    _setResponse(await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    return decodedResponse['items'][0]['track']['id'];
  }

  Future<Track> getTrackInfo(String id) async {
    var url = Uri.https('api.spotify.com', 'v1/tracks/$id');
    var token = await _getAccessToken();
    _setResponse(await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    return Track(decodedResponse['artists'][0]['name'], decodedResponse['name'],
        decodedResponse['album']['images'][0]['url']);
  }

  addToPLaylist(String id) async {
    var res = await _getPlaylist();
    if (!res) {
      await _createPlaylist();
    }
    //TODO : add to playlist
  }

  dynamic _getPlaylist() async {
    var url = Uri.https('api.spotify.com', 'v1/me/playlists', {'limit': '50'});
    var token = await _getAccessToken();
    _setResponse(await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    var daflplaylist = decodedResponse['items']
        .where((element) => element['name'] == _playlistName)
        .toList();
    if (daflplaylist.length == 1) {
      return daflplaylist[0]['uri'].substring(
          17); //17 char because format is 'spotify:playlist:MYPLAYLISTID'
    }
    return false;
  }

  _createPlaylist() async {
    var token = await _getAccessToken();
    var id = await _getIdUser();
    var url = Uri.https('api.spotify.com', 'v1/users/$id/playlists');
    _setResponse(await _client.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$_tokenType $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'name': _playlistName,
          'description':
              'Retrouvez toutes vos découvertes faites sur DaflMusic 🎵',
          'public': 'true'
        })));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    _idUser = decodedResponse['id'];
  }

  Future<String> _getIdUser() async {
    if (_idUser == null) {
      await _getIdUserApi();
    }
    return _idUser!;
  }

  _getIdUserApi() async {
    var url = Uri.https('api.spotify.com', 'v1/me');
    var token = await _getAccessToken();
    _setResponse(await _client.get(url, headers: <String, String>{
      'Authorization': '$_tokenType $token',
      'Content-Type': 'application/json'
    }));
    var decodedResponse = jsonDecode(utf8.decode(_response.bodyBytes)) as Map;
    _idUser = decodedResponse['id'];
  }
}