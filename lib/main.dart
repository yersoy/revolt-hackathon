import 'package:flutter/material.dart';
import 'package:revolt/Views/Dashboard.dart';
import 'package:revolt/Views/Register.dart';
import 'package:revolt/Views/Splash.dart';
import 'package:revolt/Views/Wellcome.dart';
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
        '/wellcome': (context) => Wellcome(),
        '/dashboard': (context) => Dashboard(),
        '/login': (context) => Register(),
      },
      initialRoute: "/splash",
    );
  }
}
