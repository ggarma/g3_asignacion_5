import 'package:flutter/material.dart';
import 'package:g3_asignacion_5/splash_screen/SplashScreen.dart';
import 'package:g3_asignacion_5/views/HomeView.dart';
import 'package:g3_asignacion_5/views/Login.dart';

void main() {
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
        '/home': (context) => HomeView(),
      },
    );
  }
}
