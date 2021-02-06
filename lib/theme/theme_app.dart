import 'package:flutter/material.dart';
import 'package:revolt/theme/theme_colors.dart';

class AppTheme{
  const AppTheme();
/// THIS CLASS DEFINES THE APP THEME Infos

  static ThemeData RevoltTheme = ThemeData(
    backgroundColor: ThemeColor.background,
    primaryColor: ThemeColor.purple,
    cardTheme: CardTheme( color: ThemeColor.background),
    textTheme: TextTheme(headline4: TextStyle(color: ThemeColor.black )),
    iconTheme: IconThemeData(color: ThemeColor.iconColor),
    bottomAppBarColor: ThemeColor.background,
    dividerColor: ThemeColor.background,
    primaryTextTheme: TextTheme(bodyText2: TextStyle(color: ThemeColor.titleTextColor))

  );


  static EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(horizontal: 10,);

  static double fullWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static double fullHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
}