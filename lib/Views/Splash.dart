import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:revolt/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<dynamic> loadingFuture;
  String redirectString;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadingFuture = Utils.loadingFuture();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
        future: loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(65),
                child: FlareActor(
                  "assets/flare/logo.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "idle",
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (FirebaseAuth.instance.currentUser != null) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/dashboard", (route) => false);
              } else {
                Navigator.pushReplacementNamed(context, '/welcome');
              }
            });
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 200.0,
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
