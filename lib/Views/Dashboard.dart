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
  bool teacher = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeColor.background,
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Image.asset("assets/images/logo.png", fit: BoxFit.fill),
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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: teacher ? TeacherHome() : StudentHome(),
    );
  }
}
