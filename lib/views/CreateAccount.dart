import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _repeatPasswordController = TextEditingController();
  bool obscure = true;

  void navigateToLogin(){
    Navigator.pushNamed(context, '/login');
  }

  void navigateToResetPassword(){
    Navigator.pushNamed(context, '/resetPassword');
  }

  void showErrorMessage(String message){
    showDialog(
      context:context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 133, 124),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color:Colors.black)),)
        );
      } );
  }

  void signUserIn() async{
    try{

      if(_passwordController.text != _repeatPasswordController.text){
        showErrorMessage("Las contraseñas no coinciden");
      }
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text
        );

        String uid = userCredential.user!.uid;
        print("Logged in");
        Navigator.pushReplacementNamed(context, '/home',arguments:{'id':uid});
      
    }on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }

  }

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
                  ? AndroidSecuredField(
                      'Repetir contraseña', _repeatPasswordController, onTap, obscure)
                  : IOSSecuredField(
                      'Repetir contraseña', _repeatPasswordController, onTap, obscure),
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
                          (){},
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
                      child: AndroidButton(
                          Text("Ingresar al Sistema"),
                          () {navigateToLogin();},
                          Color.fromARGB(255, 198, 198, 198),
                          Color.fromARGB(255, 0, 0, 0)),
                    )
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(Text("Ingresar al Sistema"), 
                      () {navigateToLogin();},
                          Color.fromARGB(255, 198, 198, 198)),
                    ),
              Platform.isAndroid
                  ? SizedBox(
                      width: 333,
                      child: AndroidButton(
                          Text("Recuperar contraseña"),
                          () {navigateToResetPassword();},
                          Color.fromARGB(255, 198, 198, 198),
                          Color.fromARGB(255, 0, 0, 0)),
                    )
                  : Container(
                      width: 333,
                      margin: EdgeInsets.only(bottom: 10),
                      child: IOSButton(Text("Recuperar contraseña"), 
                      () {navigateToResetPassword();},
                          Color.fromARGB(255, 198, 198, 198)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
