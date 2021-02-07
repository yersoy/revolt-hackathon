import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services.dart';
import '../models.dart';

class Classroom extends StatefulWidget {
  Classroom({Key key}) : super(key: key);

  @override
  _ClassroomState createState() => _ClassroomState();
}

class _ClassroomState extends State<Classroom> {
  Lesson _lesson = new Lesson();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Sınıf Ekle'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          print(_lesson.toJson());
        },
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.withOpacity(0.2),
              child: Container(
                padding: EdgeInsets.only(left: 12.0),
                child: ListTile(
                  title: TextFormField(
                    onChanged: (value) {
                      _lesson.lessonName = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Sınıf Adı",
                        icon: Icon(Icons.book),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.withOpacity(0.2),
              child: Container(
                padding: EdgeInsets.only(left: 12.0),
                child: ListTile(
                  title: TextFormField(
                    onChanged: (value) {
                      _lesson.lessonType = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Ders Konusu",
                        icon: Icon(Icons.merge_type),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.withOpacity(0.2),
              child: Container(
                padding: EdgeInsets.only(left: 12.0),
                child: ListTile(
                  title: TextFormField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        hintText: "Ders Tarihi",
                        icon: Icon(Icons.date_range),
                        border: InputBorder.none),
                    onChanged: (value) {
                      _lesson.start = DateTime.parse(value);
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.withOpacity(0.2),
              child: Container(
                padding: EdgeInsets.only(left: 12.0),
                child: ListTile(
                  title: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _lesson.lessonDuration = int.parse(value);
                    },
                    decoration: InputDecoration(
                        hintText: "Ders Dakikası",
                        icon: Icon(FontAwesomeIcons.clock),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
