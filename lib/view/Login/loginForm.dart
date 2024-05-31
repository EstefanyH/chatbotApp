import 'package:appchatbot/misc/constant.dart';
import 'package:appchatbot/misc/validator.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/view/Login/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModel/userViewModel.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UserViewModel>().loginFormKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBoxH30(),
            TextFormField(
              textInputAction: TextInputAction.next,  
              controller: emailController,
              decoration: formDecoration('Usuario', Icons.mail_outline),
            ),
            const SizedBoxH10(),
            TextFormField(
              textInputAction: TextInputAction.done, 
              controller: passwordController,
              decoration: formDecoration('Password', Icons.lock_outline),
            ),
            const SizedBoxH20(),
            //SIGN IN BUTTON
            CupertinoButton(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.indigo,
              child: const Text('Ingresar', 
                style: style16White,), 
              onPressed: () {
                context.read<UserViewModel>().loginUserInUI(
                  context, 
                  email: emailController.text.trim(),
                  password: passwordController.text.trim());
              }),
            const SizedBoxH10(),
            CupertinoButton(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
              child: const Text('Registrate',
              style: style16Indigo,),
              onPressed: () { 
                Navigator.popAndPushNamed(context, RouteManager.registerPage);
              })
          ],),),
    );
  }
}