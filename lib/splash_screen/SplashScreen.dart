import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/Services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      FirebaseAuth.instance.authStateChanges().listen((event) async {
        var uid = event?.uid;
        print(uid);
        if (uid != null) {
          var user = await getUserValidation(uid);
          Navigator.pushReplacementNamed(context, '/home',
              arguments: {'id': user['id']});
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 132,
              height: 132,
              child: Image.asset('assets/icon.png',
                  fit: BoxFit.fill, color: Colors.orange),
            ),
            SizedBox(
              width: 132,
              height: 52,
              child: Center(
                child: Text(
                  'ULGRAM',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
