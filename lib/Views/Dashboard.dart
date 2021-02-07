import 'package:flutter/material.dart';
import 'package:revolt/Views/StudentHome.dart';
import 'package:revolt/Views/TeacherHome.dart';
import 'package:revolt/services.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool teacher;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          width: 50,
        ),
      ),
      body: teacher ? TeacherHome() : StudentHome(),
    );
  }
}
