import 'package:appchatbot/misc/constant.dart';
import 'package:appchatbot/misc/validator.dart';
import 'package:appchatbot/network/accountService.dart';
import 'package:appchatbot/route/routeManager.dart';
import 'package:appchatbot/viewModel/accountViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RegisterForm extends AccountViewModel {
  AccountService get loginViewModel => context.read<AccountService>();
  
  late TextEditingController _phoneController;
  late TextEditingController _dniController;
  late TextEditingController _passwordController;
  late TextEditingController _repeatpasswordController;
  late TextEditingController _companyController;

  @override
  void initState() {
    super.initState(); 
    _phoneController = TextEditingController();
    _dniController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatpasswordController = TextEditingController();
    _companyController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _dniController.dispose();
    _passwordController.dispose();
    _repeatpasswordController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.popAndPushNamed(context, RouteManager.loginPage);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.indigo,),),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body:  SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Crear Cuenta',
                          style: titleStyleIndigo,),
                        const SizedBoxH20(),
                        TextFormField(
                          controller: _phoneController,
                          decoration: formDecoration("Telefono", Icons.phone_outlined),
                        ),
                        const SizedBoxH10(),
                        TextFormField(
                          controller: _dniController,
                          decoration: formDecoration("Dni", Icons.person_outline),
                        ),
                        const SizedBoxH10(),
                        TextFormField(
                          controller: _passwordController,
                          decoration: formDecoration("Password", Icons.lock_outline),
                        ),
                        const SizedBoxH10(),
                        TextFormField(
                          controller: _repeatpasswordController,
                          decoration: formDecoration("Confirmar Password", Icons.lock_outline),
                        ),
                        const SizedBoxH10(),
                        TextFormField(
                          controller: _repeatpasswordController,
                          decoration: formDecoration("Company", Icons.person_outline),
                        ),
                        const SizedBoxH20(),
                        CupertinoButton(
                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.indigo,
                          child: const Text('Registrar', style: style16White,), 
                          onPressed: () {
                            createdUserInUI(
                              phone: _phoneController.text.trim(), 
                              dni: _dniController.text.trim(), 
                              password: _passwordController.text.trim(), 
                              company: _companyController.text.trim());
                          })
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ),

    );
  }


}