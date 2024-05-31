
import 'dart:convert';

import 'package:appchatbot/request/UserRequest.dart';
import 'package:appchatbot/response/loginResponse.dart';
import 'package:appchatbot/response/userResponse.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/service/apiConstant.dart';
import 'package:appchatbot/util/constantGlobal.dart';
import 'package:appchatbot/widget/dialog.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:http/http.dart' as http;

class UserViewModel with ChangeNotifier{
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  void loginUserInUI(BuildContext context, {
    required String email, required String password
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if(loginFormKey.currentState?.validate() ?? false) {
      
      authentification(context, UserResquest(dni: email, password: password));

      //Navigator.of(context).popAndPushNamed(RouteManager.chatAppHomePage);
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

Future<void> authentification(BuildContext context, UserResquest request) async {
  // Define la URL de la API
  final url = Uri.parse(APIConstant.API_LOGIN);

  // Haz la solicitud POST
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': APIConstant.ContentType, 
      },
      body: jsonEncode(request.toJson()), // Convierte el cuerpo a JSON
    );

    // Verifica el estado de la respuesta
    if (response.statusCode == 200) {
      // Decodifica la respuesta si es un JSON 
      final data = LoginResponse.fromJson(jsonDecode(response.body));
      print('Respuesta de la API: $data');
      Token = data.token;
      
      Navigator.of(context).popAndPushNamed(RouteManager.chatAppHomePage);

    } else { 
      print('Error en la solicitud: ${response.statusCode}');
    }
  } catch (error) {
    // Maneja cualquier otro error
    print('Error en la solicitud: $error');
  }
}

/*
  Future<void> fetchUser(String userId) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(APIService.Login);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        user = User.fromJson(responseBody);
      } else {
        // Manejo de errores
        throw Exception('Error al cargar el usuario');
      }
    } catch (error) {
      // Manejo de errores
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  */
}