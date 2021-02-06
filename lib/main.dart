import 'package:flutter/material.dart';
import 'package:revolt/Views/Dashboard.dart';
import 'package:revolt/Views/Login.dart';
import 'package:revolt/Views/Register.dart';
import 'package:revolt/Views/Splash.dart';
import 'package:revolt/Views/Welcome.dart';
import 'package:revolt/Views/AuthCase.dart';
import 'package:revolt/theme.dart';

void main() async {
  runApp(MyApp());
}

/// This Function is called first
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Revolt Hackathon",
      theme: AppTheme.RevoltTheme,
      routes: {
        '/splash': (context) => Splash(),
        '/welcome': (context) => Welcome(),
        '/dashboard': (context) => Dashboard(),
        '/register': (context) => Register(),
        '/login': (context) => Login(),
        '/authcase': (context) => AuthCase(),
      },
      initialRoute: "/splash",
    );
  }
}
