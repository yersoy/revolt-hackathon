import 'package:flutter/material.dart';


/// ___________________My own Importations_______________________
import 'package:revolt/pages/splash_screen/splash_screen.dart';
import 'package:revolt/pages/opening_page/opening_page.dart';


/// This class contains all the Routes to the screens in the app
class Routes{
  static Map<String, WidgetBuilder> getRoute(){
    return <String, WidgetBuilder>{
      '/':(_) => SplashScreen(),
      '/opening_page':(_) => OpeningPage(),
    };

  }



}