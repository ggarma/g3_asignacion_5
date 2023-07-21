import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder:(context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Si el estado de conexión es "waiting", es decir, el stream está esperando la respuesta, muestra un indicador de carga o cualquier otro widget que desees.
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            String uid = snapshot.data!.uid;
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, '/home', arguments: {'id': uid});
            });
          } else {
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, '/login');
            });
          }
          return Container(); 
          // //inició sesión?
          //   if(snapshot.hasData){
          //     String uid = snapshot.data!.uid;
          //     Navigator.pushReplacementNamed(context, '/home',arguments:{'id':uid});
          //   }
          // //no inició sesión?
          // else{
          //   Navigator.pushReplacementNamed(context, '/login');
          // }
        }
      ),
    );
  }
}
