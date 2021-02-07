import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewClass extends StatefulWidget {
  NewClass({Key key}) : super(key: key);

  @override
  _NewClassState createState() => _NewClassState();
}

class _NewClassState extends State<NewClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Sınıf Ekle"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewClass(),
            ),
          );
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Register"),
          ),
        ],
      ),
    );
  }
}
