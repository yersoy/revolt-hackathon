import 'package:flutter/material.dart';


/// ___________________My own Importations_______________________

import 'package:revolt/pages/splash_screen/splash_content.dart';
import 'package:revolt/theme/theme_extention.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Merhaba",
      "image": "assets/svg/teaching_opening.svg"
    },
    {
      "text": " ",
      "image": "assets/svg/world_opening.svg"
    },
    {
      "text": " ",
      "image": "assets/svg/school_opening.svg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: SizedBox(

        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 2),

                    RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      color: Colors.blueAccent,
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/opening_page');
                      },
                      child: Text(
                        "Devam et",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.deepOrange : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
