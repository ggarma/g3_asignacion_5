import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

//FirebaseAuth.instance

//stf tab (autocompletado del statefulwidget)
class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

//------------------------------------------------------------------------
class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  bool obscure = true;
  bool obscure2 = true;

  void navigateToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  void navigateToResetPassword() {
    Navigator.pushNamed(context, '/resetPassword');
  }

  void onTap() {
    setState(() {
      obscure = !obscure;
    });
  }

  void onTap2() {
    setState(() {
      obscure2 = !obscure2;
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
                child: Image.asset('assets/icon.png',
                    fit: BoxFit.fill, color: Colors.orange),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Crear Cuenta",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Platform.isAndroid
                  ? AndroidTextField('Correo', _emailController)
                  : IOSTextField('Correo', _emailController),
              SizedBox(
                height: 10,
              ),
              //--------------------------------------------------------------
              Platform.isAndroid
                  ? AndroidSecuredField(
                      'Contraseña', _passwordController, onTap, obscure)
                  : IOSSecuredField(
                      'Contraseña', _passwordController, onTap, obscure),
              SizedBox(
                height: 10,
              ),
              //--------------------------------------------------------------
              Platform.isAndroid
                  ? AndroidSecuredField('Repetir contraseña',
                      _repeatPasswordController, onTap2, obscure)
                  : IOSSecuredField('Repetir contraseña',
                      _repeatPasswordController, onTap2, obscure),
              SizedBox(
                height: 10,
                width: 132,
              ),
              //--------------------------------------------------------------
              Platform.isAndroid
                  ? SizedBox(
                      width: 333,
                      child: AndroidButton(
                          Text("Crear cuenta"),
                          () {},
                          Color.fromARGB(255, 255, 140, 0),
                          Color.fromARGB(255, 0, 0, 0)))
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(
                        Text("Crear cuenta"),
                        () {},
                        Color.fromARGB(255, 255, 140, 0),
                      ),
                    ),

              Platform.isAndroid
                  ? SizedBox(
                      width: 333,
                      child: AndroidButton(Text("Ingresar al Sistema"), () {
                        navigateToLogin();
                      }, Color.fromARGB(255, 198, 198, 198),
                          Color.fromARGB(255, 0, 0, 0)),
                    )
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(Text("Ingresar al Sistema"), () {
                        navigateToLogin();
                      }, Color.fromARGB(255, 198, 198, 198)),
                    ),
              Platform.isAndroid
                  ? SizedBox(
                      width: 333,
                      child: AndroidButton(Text("Recuperar contraseña"), () {
                        navigateToResetPassword();
                      }, Color.fromARGB(255, 198, 198, 198),
                          Color.fromARGB(255, 0, 0, 0)),
                    )
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(Text("Recuperar contraseña"), () {
                        navigateToResetPassword();
                      }, Color.fromARGB(255, 198, 198, 198)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}