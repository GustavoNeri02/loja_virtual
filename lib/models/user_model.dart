import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{
  //usuario final

  bool isLoading = false;

  void signUp(){

  }

  void signIn() async{
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();


  }

  void recoverPass(){

  }

  void isLoggedIn(){

  }


}