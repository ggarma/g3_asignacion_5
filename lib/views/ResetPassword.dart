import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

// FirebaseAuth auth = FirebaseAuth.getInstance();
// auth.sendPasswordResetEmail(emailAddress)

//FirebaseAuth.instance

//stf tab (autocompletado del statefulwidget)
class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

//------------------------------------------------------------------------
class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  bool _isValidEmail = true;

  bool _validateEmail() {
    // Expresión regular para validar el formato de correo electrónico.
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    setState(() {
      _isValidEmail = emailRegExp.hasMatch(_emailController.text);
    });
    return _isValidEmail;
  }

  var message = '';

  void navigateToCreateAccount() {
    Navigator.pushNamed(context, '/createAccount');
  }

  void navigateToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  void resetPasswordButton() async {
    //validar formato de correo
    if (_validateEmail()) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text)
          .then(
        (value) async {
          setState(() {
            message = "Mensaje enviado";
          });
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushNamed(context, '/login');
          });
        },
      ).onError((error, stackTrace) {
        setState(() {
          message = 'Error: No se encontró correo';
        });
      });
    } else {
      setState(() {
        message = 'Error en formato de correo.';
      });
    }
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
                child: Image.asset('assets/icon.png',
                    fit: BoxFit.fill, color: Colors.orange),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Recuperar contraseña",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                message,
                style: TextStyle(
                    color:
                        message.contains("Error") ? Colors.red : Colors.green),
              ),
              SizedBox(
                height: 15,
              ),
              Platform.isAndroid
                  ? AndroidTextField('Ingresar correo', _emailController)
                  : IOSTextField('Ingresar correo', _emailController),
              SizedBox(
                height: 40,
                width: 132,
              ),
              Platform.isAndroid
                  ? SizedBox(
                      width: 333,
                      child: AndroidButton(Text("Recuperar contraseña"), () {
                        resetPasswordButton();
                      }, Color.fromARGB(255, 255, 140, 0),
                          Color.fromARGB(255, 0, 0, 0)))
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(
                        Text("Recuperar contraseña"),
                        () {
                          resetPasswordButton();
                        },
                        Color.fromARGB(255, 255, 140, 0),
                      ),
                    ),
              Platform.isAndroid
                  ? SizedBox(
                      width: 333,
                      child: AndroidButton(Text("Crear cuenta"), () {
                        navigateToCreateAccount();
                      }, Color.fromARGB(255, 198, 198, 198),
                          Color.fromARGB(255, 0, 0, 0)),
                    )
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(Text("Crear cuenta"), () {
                        navigateToCreateAccount();
                      }, Color.fromARGB(255, 198, 198, 198)),
                    ),
              Platform.isAndroid
                  ? SizedBox(
                      width: 333,
                      child: AndroidButton(Text("Ingresar al sistema"), () {
                        navigateToLogin();
                      }, Color.fromARGB(255, 198, 198, 198),
                          Color.fromARGB(255, 0, 0, 0)),
                    )
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(Text("Ingresar al sistema"), () {
                        navigateToLogin();
                      }, Color.fromARGB(255, 198, 198, 198)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
