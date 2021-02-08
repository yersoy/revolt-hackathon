import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:revolt/Auth.dart';
import 'package:revolt/models.dart';
import 'package:revolt/services.dart';

import '../constants.dart';
import './dashboard/student.dart';
import './dashboard/teacher.dart';
import 'classroom.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future myFuture;
  bool _teacher = false;
  dynamic userid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userid = Auth.getUserCredentials().uid;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context), button = theme.buttonTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        actions: <Widget>[
          if (_teacher)
            IconButton(
              color: button.colorScheme.primary,
              icon: Icon(FontAwesomeIcons.plus),
              onPressed: () {
                Navigator.pushNamed(context, Routes.CLASSROOM);
              },
            ),
          IconButton(
            color: button.colorScheme.primary,
            icon: Icon(FontAwesomeIcons.cog),
            onPressed: () {
              Navigator.pushNamed(context, Routes.SETTINGS);
            },
          ),
        ],
      ),
      body: FutureBuilder<AppUser>(
        future: Services().users().get(userid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.teacher) {
              return Teacher();
            } else {
              return Student();
            }
          }
          return Center(
            child: Container(
              width: 150,
              child: FlareActor(
                "assets/flare/logo.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "idle",
              ),
            ),
          );
        },
      ),
      floatingActionButton: (_teacher
          ? FloatingActionButton(
              child: Icon(FontAwesomeIcons.plus),
              onPressed: () {
                Navigator.pushNamed(context, Routes.CLASSROOM);
              },
            )
          : null),
    );
  }
}
