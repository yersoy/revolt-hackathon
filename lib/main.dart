import 'package:flutter/material.dart';

/// ---------- My imports --------------------
import 'package:revolt/theme/theme_app.dart';
import 'config/routes.dart';



void main () async {
  runApp(MyApp());
}



/// This Function is called first
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Revolt Hackathon",
      theme:AppTheme.RevoltTheme,
      routes: Routes.getRoute(),
      initialRoute: "SplashPage",
    );
  }
}
