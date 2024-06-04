import 'package:appchatbot/network/loginService.dart';
import 'package:appchatbot/request/UserRequest.dart';
import 'package:appchatbot/response/loginResponse.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/util/constantGlobal.dart';
import 'package:appchatbot/view/Login/loginPage.dart';
import 'package:appchatbot/widget/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class UserViewModel extends State<LoginPage>  {
  
  LoginService get loginmanager =>  context.read<LoginService>();  
  
  bool isLoading = false;
  
  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loginUserInUI(BuildContext context, {
    required String email, required String password }) async {

    FocusManager.instance.primaryFocus?.unfocus();
    //if(loginFormKey.currentState?.validate() ?? false) {
       
      var request = UserResquest(dni: email, password: password);
      try {
      
        var data = await loginmanager.authentification(request);
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
    //}
  }

  void createdUserInUI(BuildContext context, {
    required String name, 
    required String email, 
    required String password, 
    required String confirmPassword}) async {
      FocusManager.instance.primaryFocus?.unfocus();

      //if(registerFormKey.currentState?.validate() ?? false) {
        if(confirmPassword.toString().trim() != password) { 
          showSnackBar(context, 'password do not match', 2000);
        }
        else {
          Navigator.of(context).popAndPushNamed(RouteManager.chatAppHomePage);
        }
      //}
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
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}