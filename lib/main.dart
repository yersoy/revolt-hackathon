import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'i18n.dart';
import 'constants.dart';

import './screens/splash.dart';
import './screens/welcome.dart';
import './screens/entrance.dart';
import './screens/signup.dart';
import './screens/signin.dart';
import './screens/dashboard.dart';

import './screens/search.dart';
import './screens/classroom.dart';

void main() async {
  runApp(MyApp());
}

/// This Function is called first
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Revolt Hackathon', debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
      ),
      routes: {
        Routes.SPLASH: (context) => Splash(),
        Routes.WELCOME: (context) => Welcome(),
        Routes.ENTRANCE: (context) => Entrance(),
        Routes.SIGNUP: (context) => Signup(),
        Routes.SIGNIN: (context) => Signin(),

        Routes.DASHBOARD: (context) => Dashboard(),
        Routes.CLASSROOM: (context) => Classroom(),
        Routes.SEARCH: (context) => Search(),
      },
      initialRoute: Routes.SPLASH,

      localizationsDelegates: [
        GlobalCustomLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
