import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscure = true;

  void onTap() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 96,
                height: 96,
                child: Image.asset(
                  'assets/icon.png',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Acceder al sistema",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Platform.isAndroid
                  ? AndroidTextField('username', _usernameController)
                  : IOSTextField('username', _usernameController),
              SizedBox(
                height: 10,
              ),
              Platform.isAndroid
                  ? AndroidSecuredField(
                      'password', _passwordController, onTap, obscure)
                  : IOSSecuredField(
                      'password', _passwordController, onTap, obscure)
            ],
          ),
        ),
      ),
    );
  }
}
