import 'package:appchatbot/view/Register/registerPage.dart';
import 'package:appchatbot/widget/dialog.dart';
import 'package:flutter/material.dart';

class AccountViewModel extends State<RegisterPage> {
  
  void createdUserInUI({
    required String phone, 
    required String dni,
    required String password,
    required String company}){
      showSnackBar(context, 'Bienvenido', 300);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}