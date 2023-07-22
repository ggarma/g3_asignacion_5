import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:g3_asignacion_5/splash_screen/SplashScreen.dart';
import 'package:g3_asignacion_5/views/FollowView.dart';
import 'package:g3_asignacion_5/views/HomeView.dart';
import 'package:g3_asignacion_5/views/Login.dart';
import 'package:g3_asignacion_5/views/CreateAccount.dart';
import 'package:g3_asignacion_5/views/ResetPassword.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'g5_asignacion_5',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginView(),
        '/resetPassword': (context) => ResetPasswordView(),
        '/createAccount': (context) => CreateAccountView(),
        '/home': (context) => HomeView(),
        '/follows': (context) => FollowView(),
      },
    );
  }
}