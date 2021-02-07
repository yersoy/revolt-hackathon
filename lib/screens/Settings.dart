import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:revolt/auth.dart';

import '../constants.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(FontAwesomeIcons.signOutAlt),
              title: Text("Çıkış Yap"),
              onTap: () {
                Auth.userSignOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.WELCOME, (route) => false));
              },
            ),
          ],
        ),
      ),
    );
  }
}
