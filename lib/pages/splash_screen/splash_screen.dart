import 'package:flutter/material.dart';

///____________________________ My imports ________________________
import 'package:revolt/theme/theme_extention.dart';
import 'body.dart';


class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Body(),
    );
  }
}
