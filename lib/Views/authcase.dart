import 'package:flutter/material.dart';

class AuthCase extends StatefulWidget {
  AuthCase({Key key}) : super(key: key);

  @override
  _AuthCaseState createState() => _AuthCaseState();
}

class _AuthCaseState extends State<AuthCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(45),
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Material(
                  color: Theme.of(context).primaryColor,
                  elevation: 0.0,
                  child: MaterialButton(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      "Oturum Aç",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Material(
                  color: Theme.of(context).primaryColor,
                  elevation: 0.0,
                  child: MaterialButton(
                    onPressed: () async {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      "Kayıt Ol",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          )
        ],
      ),
    );
  }
}
