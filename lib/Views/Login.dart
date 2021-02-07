import 'package:flutter/material.dart';

/// __________________ mY imports _______________________
import 'package:revolt/auth.dart';
import '../theme.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      body: Stack(children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[350],
                                blurRadius:
                                20.0, /// has the effect of softening the shadow
                              )
                            ],
                          ),
                          child: Form(
                              key: _formKey,
                              child: ListView(
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                        alignment: Alignment.topCenter,
                                        child: Image.asset(
                                          'assets/images/logo.png',
                                          width: 210.0,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        14.0, 8.0, 14.0, 8.0),
                                    child: Material(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      color: Colors.grey.withOpacity(0.2),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0),
                                        child: TextFormField(
                                          controller: _email,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "E-posta",
                                            icon:
                                            Icon(Icons.alternate_email),
                                          ),
                                          /// I don't know why these lines appear
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              Pattern pattern =
                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                              RegExp regex =
                                              new RegExp(pattern);
                                              if (!regex.hasMatch(value))
                                                return 'Please make sure your email address is valid';
                                              else
                                                return null;
                                              }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        14.0, 13.0, 14.0, 8.0),
                                    child: Material(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      color: Colors.grey.withOpacity(0.2),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0),
                                        child: TextFormField(
                                          controller: _password,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "parola",
                                            icon: Icon(Icons.lock_outline),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Parola alanı boş olamaz";
                                            } else if (value.length < 6) {
                                              return "Şifre en az 6 karakter uzunluğunda olmalıdır";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        74.0, 21.0, 74.0, 8.0),
                                    child: Material(
                                        borderRadius:
                                        BorderRadius.circular(7.0),
                                        color: ThemeColor.accentBlue,
                                        elevation: 0.0,
                                        child: MaterialButton(
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              await Auth.login(_email.text, _password.text,context);
                                            }

                                          },
                                          minWidth: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: Text(
                                            "Oturum aç",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(
                                            "diğer ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: MaterialButton(

                                              onPressed: () async {
                                            await  Auth.signInWithGoogle(context);
                                              },
                                              child: Image.asset(
                                                "assets/images/google_search.png",
                                                width: 30,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }}

