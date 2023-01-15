import 'database_connexion.dart';
import 'saver.dart';

class DatabaseSaver implements Saver {
  // Save user in the database
  @override
  void save(String idDafl, String passw) async {
    final connection = await DatabaseConnexion.initConnexion();

    connection.execute(
        'insert into users (idDafl, idSpotify, password) values (@username, 0, @password)',
        {'id': '', 'username': idDafl, 'password': passw}).whenComplete(() {
      connection.close();
    });
    print('save');
  }
}
