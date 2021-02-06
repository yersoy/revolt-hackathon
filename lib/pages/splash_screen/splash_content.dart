import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



///__________________________ MY imports _____________________________________
import 'package:revolt/theme/theme_extention.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),

        Text(
          "Revolt Hackathon",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(25),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          style: TextStyle(fontSize: 21,fontWeight: FontWeight.w100),
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        SvgPicture.asset(
          image,
          height: getProportionateScreenHeight(340),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
