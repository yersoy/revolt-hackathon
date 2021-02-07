import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../convert.dart';
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
                    decoration: InputDecoration(hintText: 'Ders Konusu', border: InputBorder.none,
                      icon: Icon(Icons.book),
                    ),
                    onChanged: (value) { _lesson.title = value; },
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Material(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10.0),
              child: Container(padding: EdgeInsets.only(left: 12.0),
                child: ListTile(
                  title: TextFormField(
                    onChanged: (description) { _lesson.description = description; },
                    decoration: InputDecoration(hintText: 'Açıklama', border: InputBorder.none,
                      icon: Icon(Icons.merge_type),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(padding: EdgeInsets.all(12.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.withOpacity(0.2),
              child: Container(padding: EdgeInsets.only(left: 12.0),
                child: ListTile(
                  title: TextFormField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(hintText: 'Ders Tarihi', border: InputBorder.none,
                      icon: Icon(Icons.date_range),
                    ),
                    onChanged: (startDate) { _lesson.startDate = Convert.to<DateTime>(startDate); },
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
                  title: TextFormField(keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: 'Ders Süresi', border: InputBorder.none,
                      icon: Icon(FontAwesomeIcons.clock),
                    ),
                    onChanged: (duration) { _lesson.duration = int.parse(duration); },
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
