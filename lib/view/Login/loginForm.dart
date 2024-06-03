import 'package:appchatbot/misc/constant.dart';
import 'package:appchatbot/network/loginService.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/viewModel/userViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginForm extends UserViewModel {
  LoginService get loginViewModel => context.read<LoginService>();
  
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState(); 
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final userViewModel = Provider.of<LoginService>(context);
    final Size size =  MediaQuery.of(context).size; 

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children:  [ 
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    SizedBox( 
                      height: size.height * 0.1,
                    ),
                    const Text("Electrodunas",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 40.0, 
                      color: Colors.indigo,
                      fontWeight: FontWeight.w300),)
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(child: SingleChildScrollView(
                    child:  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBoxH30(),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            decoration: formDecoration('Usuario', Icons.mail_outline)
                          ),
                          const SizedBoxH10(),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                            decoration: formDecoration('Password', Icons.lock_outline)
                          ),
                          const SizedBoxH20(),
                          //SIGN IN BUTTON
                          CupertinoButton(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: Colors.indigo,
                            child: const Text( 'Ingresar', 
                              style: style16White,), 
                            onPressed: () {
  
                              loginUserInUI(context, 
                              email: _emailController.text.trim(), 
                              password: _passwordController.text.trim());
  
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
                        ],
                      ),
                    )
                  ),),
              )
            ],
          )
        ),  
      ),
    );
    
  }
}