import 'package:appchatbot/network/LoginService.dart';
import 'package:appchatbot/request/UserRequest.dart';
import 'package:appchatbot/response/loginResponse.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/util/constantGlobal.dart';
import 'package:appchatbot/widget/dialog.dart';
import 'package:flutter/cupertino.dart'; 

class UserViewModel with ChangeNotifier{
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  late LoginService service;

  bool isLoading = false;

  UserViewModel() {
    service = LoginService();
  }

  void loginUserInUI(BuildContext context, {
    required String email, required String password }) async {

    FocusManager.instance.primaryFocus?.unfocus();
    if(loginFormKey.currentState?.validate() ?? false) {
       
      var request = UserResquest(dni: email, password: password);
      try {
      
        var data = await service.authentification(request);
        LoginResponse result = LoginResponse.fromJson(data); 

        if (result != null) {

          Token = result.token;
          IdUsuario = result.user.id;
          
          Navigator.of(context).popAndPushNamed(RouteManager.chatAppHomePage);
        }

      } catch (error) {
        print('Error en la solicitud: $error');
      }
      //showSnackBar();
    }
  }

  void createdUserInUI(BuildContext context, {
    required String name, 
    required String email, 
    required String password, 
    required String confirmPassword}) async {
      FocusManager.instance.primaryFocus?.unfocus();

      if(registerFormKey.currentState?.validate() ?? false) {
        if(confirmPassword.toString().trim() != password) { 
          showSnackBar(context, 'password do not match', 2000);
        }
        else {
          Navigator.of(context).popAndPushNamed(RouteManager.chatAppHomePage);
        }
      }
  }

  void logoutUserInUI(BuildContext context) async {
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  } 

  void resetPasswordInUI(BuildContext context, {required String email}) async {
    if (email.isEmpty){
      showSnackBar(context, 'Please enter email address and click on "Reset Password"', 4000);
    } else {
      showSnackBar(context, 'Reset instruction sent to $email', 4000);
    }
  }

}