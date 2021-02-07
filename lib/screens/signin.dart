import 'package:flutter/material.dart';

import '../i18n.dart';
import '../constants.dart';
import '../models.dart';
import '../auth.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  // final Auth _auth = Auth();
  final Credentials _credentials = Credentials();

  ScaffoldState get scaffold { return _scaffold.currentState; }

  void _enter() {
    final resources = GlobalCustomLocalizations.of(context);

    showDialog(context: context, barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    Auth.login(_credentials.username, _credentials.password).then((user) {
      Navigator.pop(context);
      if (user is AppUser) { Navigator.pushNamedAndRemoveUntil(context, Routes.DASHBOARD, (route) => true); } else {
        this.scaffold.showSnackBar(SnackBar(content: Text(resources.SIGNIN_INVALID)));
      }
    });
  }

  void _submit() { FocusScope.of(context).nextFocus(); }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context), button = theme.buttonTheme;
    final resources = GlobalCustomLocalizations.of(context);

    return Scaffold(key: _scaffold,
      appBar: AppBar(backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
        leading: BackButton(color: button.colorScheme.primary,
          onPressed: () { Navigator.pop(context); },
        ),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(),
            Padding(padding: EdgeInsets.only(bottom: 24),
              child: Image.asset('assets/images/logo.png', height: 96),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextField(keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: resources.SIGNIN_USERNAME,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (username) { _credentials.username = username; },
                onSubmitted: (value) { _submit(); },
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 36.0),
              child: TextField(keyboardType: TextInputType.visiblePassword, textInputAction: TextInputAction.done, obscureText: true,
                decoration: InputDecoration(labelText: resources.SIGNIN_PASSWORD,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                onChanged: (password) { _credentials.password = password; },
                onSubmitted: (value) { _enter(); },
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(tooltip: resources.SIGNIN_ENTER,
        child: Icon(Icons.arrow_forward),
        onPressed: _enter,
      ),
    );
  }
}
