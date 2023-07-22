import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

import '../api/Services.dart';

//FirebaseAuth.instance

//stf tab (autocompletado del statefulwidget)
class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

//------------------------------------------------------------------------
class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController _usernameController = TextEditingController();
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

  Future<dynamic> getData() async {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    var user = await getUser(arguments!['id'].toString());

    var response = {
      'id': user['id'],
      'name': user['name'],
      'image_url': user['image_url']
      
    };
    return response;
  }


  void signUserUp() async {

    //Validar si coinciden las contraseñas
    if(_passwordController.text == _repeatPasswordController.text){
      await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, 
            password: _passwordController.text
            ).then((value) async {
              //llamada a la bd
              var body = {
                'email': _emailController.text,
                'password': _passwordController.text,
                'username': _usernameController.text,
                'uid': value.user!.uid,
                'name':_usernameController.text
              };
              await createAccount(body);

              //navegacion al login
              Navigator.pushReplacementNamed(context, '/login');
            },);
      
      //Falta agregar, al crear la cuenta en Firebase, debe hacerse un post a la bd
      //Con el correo ingresado, la contraseña y el uid (el id es automatico)
      //Debe consultar a firebase si existe una persona con el mismo correo

    }else{
      //Ingresar como un pop up de que las contraseñas no coinciden
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
                "Crear Cuenta",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Platform.isAndroid
                  ? AndroidTextField('Nombre de usuario', _usernameController)
                  : IOSTextField('Nombre de usuario', _usernameController),
              SizedBox(
                height: 10,
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
                          () {signUserUp();},
                          Color.fromARGB(255, 255, 140, 0),
                          Color.fromARGB(255, 0, 0, 0)))
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(
                        Text("Crear cuenta"),
                        () {signUserUp();},
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