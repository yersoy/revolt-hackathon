import 'package:flutter/material.dart';

import '../constants.dart';
import '../i18n.dart';
import '../models.dart';
import '../auth.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _scaffold = GlobalKey<ScaffoldState>();

  AppUser _user = AppUser(graduation: 0);
  bool _visible = true;

  ScaffoldState get scaffold { return _scaffold.currentState; }

  void _enter () {
    final resources = GlobalCustomLocalizations.of(context);

    _user.userName = _user.email;

    if ((_user.firstName ?? '').isEmpty) { this.scaffold.showSnackBar(SnackBar(content: Text('İsim boş olamaz'))); return; }
    if ((_user.lastName ?? '').isEmpty) { this.scaffold.showSnackBar(SnackBar(content: Text('Soyisim boş olamaz'))); return; }
    if ((_user.email ?? '').isEmpty) { this.scaffold.showSnackBar(SnackBar(content: Text('E-posta boş olamaz'))); return; }
    // if ((_user.graduation ?? 0) < 0) { this.scaffold.showSnackBar(SnackBar(content: Text('Eğitim seviyenizi seçmelisiniz'))); return; }
    if ((_user.password ?? '').isEmpty) { this.scaffold.showSnackBar(SnackBar(content: Text('Parola boş olamaz'))); return; }
    if ((_user.password ?? '').length > 6) { this.scaffold.showSnackBar(SnackBar(content: Text('Parola 6 karakterden kısa olamaz'))); return; }

    showDialog(context: context, barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    Auth.registerWithEmail(_user,context).then((user) {
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

    return Scaffold(key: _scaffold,
      appBar: AppBar(backgroundColor: Colors.transparent, shadowColor: Colors.transparent,
        leading: BackButton(color: button.colorScheme.primary,
          onPressed: () { Navigator.pop(context); },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(bottom: 16.0),
                child: Image.asset('assets/images/register.png', width: 200.0),
              ),
              Container(margin: EdgeInsets.only(bottom: 16.0), padding: EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(color: theme.focusColor, borderRadius: BorderRadius.circular(8.0)),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'İsim', border: InputBorder.none,
                    icon: Icon(Icons.person_outline),
                  ),
                  onChanged: (firstName) { _user.firstName = firstName; },
                  onFieldSubmitted: (e) { _submit(); },
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 16.0), padding: EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(color: theme.focusColor, borderRadius: BorderRadius.circular(8.0)),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Soyisim', border: InputBorder.none,
                    icon: Icon(Icons.person_outline_rounded),
                  ),
                  onChanged: (lastName) { _user.lastName = lastName; },
                  onFieldSubmitted: (e) { _submit(); },
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 16.0), padding: EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(color: theme.focusColor, borderRadius: BorderRadius.circular(8.0)),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'E-posta', border: InputBorder.none,
                    icon: Icon(Icons.alternate_email),
                  ),
                  onChanged: (email) { _user.email = email; },
                  onFieldSubmitted: (e) { _submit(); },
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 16.0), padding: EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(color: theme.focusColor, borderRadius: BorderRadius.circular(8.0)),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Eğitim seviyesi', border: InputBorder.none,
                    icon: Icon(Icons.drive_file_rename_outline),
                  ),
                  onChanged: (graduation) { _user.graduation = int.parse(graduation); },
                  onFieldSubmitted: (e) { _submit(); },
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 16.0), padding: EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(color: theme.focusColor, borderRadius: BorderRadius.circular(8.0)),
                child: Row(
                  children: [
                    Expanded(child: Text('Eğitim alacağım')),
                    Checkbox(value: _user.teacher,
                      onChanged: (value) { setState(() { _user.teacher = !_user.teacher; }); },
                    ),
                    Expanded(child: Text('Eğitim vereceğim')),
                    Checkbox(value: _user.student,
                      onChanged: (value) { setState(() { _user.student = !_user.student; }); },
                    ),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 16.0), padding: EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(color: theme.focusColor, borderRadius: BorderRadius.circular(8.0)),
                child: TextFormField(obscureText: _visible,
                  decoration: InputDecoration(hintText: 'Parola', border: InputBorder.none,
                    icon: Icon(Icons.lock_outline),
                    suffixIcon: InkWell(borderRadius: BorderRadius.circular(32.0),
                      child: Icon(_visible ? Icons.visibility : Icons.visibility_off),
                      onTap: () { setState(() { _visible = !_visible; }); },
                    ),
                  ),
                  validator: (password) { return (password.isEmpty ? 'Boş olamaz' : (password.length < 6 ? 'En azından 6 karakter olmalı' : null)); },
                  onChanged: (password) { _user.password = password; },
                  onFieldSubmitted: (e) { _submit(); },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('Kayıt Ol', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0)),
                  ),
                  onPressed: this._enter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
