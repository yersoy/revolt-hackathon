import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  //TextEditingController _email = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _education = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TextEditingController datecontroller = TextEditingController();
  String presentText;

  void _selectDate() async {
    DateFormat dateFormat = DateFormat("dd / MM / yyyy ");
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        datecontroller.text = dateFormat.format(picked);
      });
  }

  bool hidePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[350],
                    blurRadius: 20.0, // has the effect of softening the shadow
                  )
                ],
              ),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'assets/images/register.png',
                              width: 200.0,
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                    hintText: "Isim",
                                    icon: Icon(Icons.person_outline),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Boş olamaz";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _surname,
                                decoration: InputDecoration(
                                    hintText: "Soyisim",
                                    icon: Icon(Icons.person_outline_rounded),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Boş olamaz";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _education,
                                decoration: InputDecoration(
                                    hintText: "Eğitim seviyesi",
                                    icon: Icon(Icons.drive_file_rename_outline),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Boş olamaz";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _phone,
                                decoration: InputDecoration(
                                    hintText: "Telefon Numarası",
                                    icon: Icon(Icons.phone),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Boş olamaz";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                controller: _password,
                                obscureText: hidePass,
                                decoration: InputDecoration(
                                    hintText: "Parola",
                                    icon: Icon(Icons.lock_outline),
                                    border: InputBorder.none),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Boş olamaz ";
                                  } else if (value.length < 6) {
                                    return "En azından 6 karakter olmalı";
                                  }
                                  return null;
                                },
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      hidePass = false;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () async {},
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
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
