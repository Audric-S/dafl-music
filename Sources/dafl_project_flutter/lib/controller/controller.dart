import '../persistence/database_loader.dart';
import '../persistence/database_saver.dart';
import '../persistence/loader.dart';

import '../persistence/saver.dart';
import '../persistence/loader.dart';
import '../model/user.dart';


class Controller{
  static Controller? _this;

  static Saver? saver = DatabaseSaver();
  static Loader? loader = DatabaseLoader();

  User currentUser = User(null, null);

  factory Controller(){
    if (_this == null) _this = Controller._();
    return _this!;
  }

  Controller._();

  void save(User userToSave){
    saver?.save(userToSave);
  }

  void load(String username, String password) async{
    currentUser =  await loader?.load(username, password) as User;
  }

  User createUser(String username, String password){
    return User(username, password);
  }

  void changeCurrentUser(User user){
    this.currentUser = user;
  }

  void changeUsernameCourant(String newName){
    if(newName !=null){
      this.currentUser.usernameDafl = newName;
    }
  }
  void changePasswordCourant(String newPass){
    if(newPass !=null){
      this.currentUser.passwDafl = newPass;
    }
  }
}
