import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../main.dart';

class Location {
  static Future<Map<String, dynamic>> sendCurrentLocation() async {
    Uri uri = Uri.parse("https://codefirst.iut.uca.fr/containers/php_script-dorianhodin/insert.php");
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        //faire l'interface gra pour gérer ça
        return Future.error('Location Not Available');
      }
    }
    String actualUser = MyApp.controller.currentUser.usernameDafl;
    String actualSong = await MyApp.api.getCurrentlyPlayingTrack();
    Position current = await Geolocator.getCurrentPosition();
    await http.post(uri, body: {
      "id": actualUser.toString(),
      "latitude": current.latitude.toString(),
      "longitude": current.longitude.toString(),
      "idMusic": actualSong.toString(),
    });
    return getData();
  }

  static Future<Map<String, dynamic>> getData() async {
    Map<String, dynamic> spot = {};
    String actualUser = MyApp.controller.currentUser.usernameDafl;
    Uri uri = Uri.parse("https://codefirst.iut.uca.fr/containers/php_script-dorianhodin/distance.php");
    http.Response response = await http.post(uri, body: {
      "id": actualUser,
    });
    var data = jsonDecode(response.body);
    if (data.runtimeType==String) {
      if (data=="Failed to connect to MySQL, connection timeout"){
        return Future.error(data);
      }else if (data=="The POST didn't return any values"){
        return Future.error(data);
      }else{
        return Future.error(data);        //ERROR No user found in the database
      }
    }else {
      data.forEach((s) => spot.putIfAbsent(s['user'], () => s['music']));
      return spot;
    }
  }
}

