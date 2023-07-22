import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g3_asignacion_5/api/Services.dart';
import 'package:g3_asignacion_5/components/androidComponents/androidComponent.dart';
import 'package:g3_asignacion_5/components/iosComponents/iosComponent.dart';

//FirebaseAuth.instance

//stf tab (autocompletado del statefulwidget)
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

//------------------------------------------------------------------------
class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscure = true;

  void navigateToCreateAccount() {
    Navigator.pushNamed(context, '/createAccount');
  }

  void navigateToResetPassword() {
    Navigator.pushNamed(context, '/resetPassword');
  }

  //Método de Inicio de Sesión
  // void signUserIn() async{
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: _emailController.text,
  //     password: _passwordController.text)
  //     .then((value) async {

  //     });
  // }

  void signUserIn() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

    if (userCredential.user != null) {
      String uid = userCredential.user!.uid;
      var user = await getUserValidation(uid);
      if (user['name'] != '') {
        print("Logged in");
        Navigator.pushReplacementNamed(context, '/home',
            arguments: {'id': user['id']});
      } else {
        print('No se pudo obtener el usuario después de iniciar sesión.');
      }
    } else {
      print('No se pudo obtener el usuario después de iniciar sesión.');
    }
  }

  void onTap() {
    //FirebaseAuth.instance. [autocompletado]
    setState(() {
      //luego del .then es para que se ejecute luego
      // .then((value) async {
      //                 id = value.user!.uid;
      //                 print("Logged In");
      //                 Navigator.pushReplacementName(
      //                     );
      //               });
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
                child: Image.asset('assets/icon.png',
                    fit: BoxFit.fill, color: Colors.orange),
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
                  ? AndroidTextField('Correo', _emailController)
                  : IOSTextField('Correo', _emailController),
              SizedBox(
                height: 10,
              ),
              Platform.isAndroid
                  ? AndroidSecuredField(
                      'Contraseña', _passwordController, onTap, obscure)
                  : IOSSecuredField(
                      'Contraseña', _passwordController, onTap, obscure),
              SizedBox(
                height: 40,
                width: 132,
              ),
              Platform.isAndroid
                  ? SizedBox(
                      width: 333,
                      child: AndroidButton(Text("Iniciar sesión"), () {
                        signUserIn();
                      }, Color.fromARGB(255, 255, 140, 0),
                          Color.fromARGB(255, 0, 0, 0)))
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(
                        Text("Iniciar sesión"),
                        () {
                          signUserIn();
                        },
                        Color.fromARGB(255, 255, 140, 0),
                      ),
                    ),
              Platform.isAndroid
                  ? SizedBox(
                      width: 333,
                      child: AndroidButton(
                          Text("Ingresar con Google"),
                          () {},
                          Color.fromARGB(255, 1, 150, 43),
                          const Color.fromARGB(255, 255, 255, 255)),
                    )
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(Text("Ingresar con Google"), () {},
                          Color.fromARGB(255, 1, 150, 43)),
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