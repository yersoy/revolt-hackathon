import 'package:flutter/material.dart';
import 'package:revolt/Views/StudentHome.dart';
import 'package:revolt/Views/TeacherHome.dart';
import 'package:revolt/services.dart';

import '../theme.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool teacher = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /// ---------------------------------------------------------
  /// Here is the app bar of the app which can be changed
  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ThemeColor.background,
      leading:  Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          child: Container(
            // height: 40,
            // width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child:Image.asset("assets/images/logo.png", fit: BoxFit.fill)

          ),
        ),
      ),

      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            size: 30,
            color: ThemeColor.grey,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/search_page');
          },
        ),

        IconButton(
          icon: Icon(
            Icons.notifications,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {

          },
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: teacher ? TeacherHome() : StudentHome(),
    );
  }
}
