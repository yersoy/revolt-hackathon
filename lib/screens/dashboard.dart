import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  bool _teacher = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context), button = theme.buttonTheme;

    return Scaffold(
      appBar: AppBar(elevation: 3.0,
        backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
        leading: Padding(padding: EdgeInsets.only(left: 8.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        actions: <Widget>[
          IconButton(color: button.colorScheme.primaryVariant,
            icon: Icon(Icons.search),
            onPressed: () { },
          ),
          IconButton(color: button.colorScheme.primary,
            icon: Icon(Icons.notifications),
            onPressed: () { },
          ),
        ],
      ),
      body: (_teacher ? Teacher() : Student()),
      floatingActionButton: (_teacher ? FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        onPressed: () { Navigator.pushNamed(context, Routes.CLASSROOM); },
      ) : null),
    );
  }
}
