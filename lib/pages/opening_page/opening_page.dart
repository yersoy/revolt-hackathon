  import 'package:flutter/material.dart';
import 'package:revolt/theme/theme_colors.dart';


///_____________________My imports _______________________
  import 'package:revolt/theme/theme_textstyle.dart';
  import 'package:revolt/theme/theme_extention.dart';
  import 'package:revolt/theme/theme_app.dart';


  class OpeningPage extends StatefulWidget {
    @override
    _OpeningPageState createState() => _OpeningPageState();
  }

  class _OpeningPageState extends State<OpeningPage> {

    Widget _iWantToTeachCard(String title, String subtitle) {
      TextStyle titleStyle = TextStyles.title.bold.black;
      TextStyle subtitleStyle = TextStyles.title.bold.black;
      if (AppTheme.fullWidth(context) < 392) {
        titleStyle = TextStyles.title.bold.black;
        subtitleStyle = TextStyles.title.bold.black;
      }
      return AspectRatio(
        aspectRatio: 12 / 8,
        child: Container(
          height: 280,
          width: AppTheme.fullWidth(context) * .3,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/teacher.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(4, 4),
                blurRadius: 10,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              child: Stack(
                children: <Widget>[
                  // Positioned(
                  //   top: -20,
                  //   left: -20,
                  //   child: CircleAvatar(
                  //     backgroundColor: lightColor,
                  //     radius: 60,
                  //   ),
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Text(title, style: titleStyle).hPadding8,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: Text(
                          subtitle,
                          style: subtitleStyle,
                        ).hPadding8,
                      ),
                    ],
                  ).p16
                ],
              ),
            ),
          ).ripple(() {
            Navigator.pushReplacementNamed(context, '/Homepage');
          }, borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      );
    }

    Widget _iWantToLearnCard(String title, String subtitle) {
      TextStyle titleStyle = TextStyles.title.bold.black;
      TextStyle subtitleStyle = TextStyles.body.bold.black;
      if (AppTheme.fullWidth(context) < 392) {
        titleStyle = TextStyles.title.bold.black;
        subtitleStyle = TextStyles.title.bold.black;
      }
      return AspectRatio(
        aspectRatio: 12 / 8,
        child: Container(
          height: 280,
          width: AppTheme.fullWidth(context) * .3,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/students.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(4, 4),
                blurRadius: 10,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              child: Stack(
                children: <Widget>[
                  // Positioned(
                  //   top: -20,
                  //   left: -20,
                  //   child: CircleAvatar(
                  //     backgroundColor: lightColor,
                  //     radius: 60,
                  //   ),
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Text(title, style: titleStyle).hPadding8,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: Text(
                          subtitle,
                          style: subtitleStyle,
                        ).hPadding8,
                      ),
                    ],
                  ).p16
                ],
              ),
            ),
          ).ripple(() {

          }, borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
            body:Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 70,),
                  _iWantToTeachCard("",""),
                  Divider( color: ThemeColor.black,height: getProportionateScreenHeight(1),),
                  SizedBox(height: 4,),
                  Text("Eğitim vermek isterim", style: TextStyles.titleNormal,),
                  SizedBox(height: 35,),
                  _iWantToLearnCard("", ""),
                  Divider( color: ThemeColor.black,height: getProportionateScreenHeight(1),),
                  SizedBox(height: 4,),
                  Text("Eğitim almak isterim", style: TextStyles.titleNormal,),
                ],
              ),
            )

        ),

      );
    }
  }