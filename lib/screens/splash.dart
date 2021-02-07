import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';
import '../utils.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String redirectString;

  @override
  void initState() {
    super.initState();

    Utils.loadingFuture().then((success) {
      Navigator.pushReplacementNamed(
          context,
          FirebaseAuth.instance.currentUser != null
              ? Routes.DASHBOARD
              : Routes.WELCOME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          child: FlareActor(
            "assets/flare/logo.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "idle",
          ),
        ),
      ),
    );
  }
}
