import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme();
  static ThemeData RevoltTheme = ThemeData(
    backgroundColor: ThemeColor.background,
    primaryColor: ThemeColor.accentBlue,
    cardTheme: CardTheme(color: ThemeColor.background),
    textTheme: GoogleFonts.poppinsTextTheme(),
    iconTheme: IconThemeData(color: ThemeColor.iconColor),
    bottomAppBarColor: ThemeColor.background,
    dividerColor: ThemeColor.background,
    primaryTextTheme: TextTheme(
      bodyText2: TextStyle(color: ThemeColor.titleTextColor),
    ),
  );

  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

class FontSizes {
  static double scale = 1.2;
  static double get body => 14 * scale;
  static double get bodySm => 12 * scale;
  static double get title => 16 * scale;
  static double get titleSmall => 16 * scale;
  static double get titleM => 18 * scale;
  static double get sizeXXl => 28 * scale;
  static double get sizeXl => 17 * scale;
  static double get Large => 23 * scale;
}

class TextStyles {
  static TextStyle get title => TextStyle(fontSize: FontSizes.title);
  static TextStyle get titleM => TextStyle(fontSize: FontSizes.titleM);
  static TextStyle get titleNormal =>
      title.copyWith(fontWeight: FontWeight.w500);
  static TextStyle get titleMedium =>
      titleM.copyWith(fontWeight: FontWeight.w300);
  static TextStyle get h1Style =>
      TextStyle(fontSize: FontSizes.sizeXXl, fontWeight: FontWeight.bold);
  static TextStyle get h2Style => TextStyle(
      fontSize: FontSizes.sizeXl,
      fontWeight: FontWeight.bold,
      color: Colors.black);
  static TextStyle get h3Large => TextStyle(
      fontSize: FontSizes.Large,
      fontWeight: FontWeight.bold,
      color: Colors.black);
  static TextStyle get headTitleColored => TextStyle(
      fontSize: FontSizes.Large,
      fontWeight: FontWeight.bold,
      color: Colors.black);
  static TextStyle get body =>
      TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300);
  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
}

class ThemeColor {
  static const Color background = Color(0XFFfefefe);

  static const Color titleTextColor = const Color(0xff1b1718);
  static const Color subTitleTextColor = const Color(0xffb9bfcd);

  static const Color skyBlue = Color(0xff71b4fb);
  static const Color lightBlue = Color(0xff7fbcfb);
  static const Color extraLightBlue = Color(0xffd9eeff);
  static const Color accentBlue = Colors.blueAccent;

  static const Color orange = Color(0xfffa8c73);
  static const Color lightOrange = Color(0xfffa9881);
  static const Color accentOrange = Color(0xffff7043);

  static const Color purple = Color(0xff8873f4);
  static const Color purpleLight = Color(0xff9489f4);
  static const Color purpleExtraLight = Color(0xffb1a5f6);

  static const Color grey = Color(0xffb8bfce);

  static const Color iconColor = Color(0xff000000);
  static const Color green = Color(0xff4cd1bc);
  static const Color lightGreen = Color(0xff5ed6c3);

  static const Color black = Color(0xff20262C);
  static const Color lightblack = Color(0xff5F5F60);
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

/// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;

  /// 812 is the layout height that most smartphones use
  return (inputHeight / 812.0) * screenHeight;
}

/// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;

  /// 375 is the layout width that most phone use
  return (inputWidth / 375.0) * screenWidth;
}
