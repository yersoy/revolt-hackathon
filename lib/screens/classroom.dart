import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:revolt/i18n.dart';

import '../Auth.dart';
import '../convert.dart';

import '../models.dart';
import '../services.dart';

class Classroom extends StatefulWidget {
  Classroom({Key key}) : super(key: key);

  @override
  _ClassroomState createState() => _ClassroomState();
}

class _ClassroomState extends State<Classroom> {
  Lesson _lesson = new Lesson();
  @override
  void initState() {
    super.initState();
    _lesson.userId = Auth.getUserCredentials().uid;
  }

  Future<Iterable<Education>> _educations() {
    return Services().educations().all();
  }

  @override
  Widget build(BuildContext context) {
    final resources = GlobalCustomLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Yeni Ders Ekle'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Services().lessons().save(_lesson).then((value) => Navigator.pop(context));
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
                  leading: Icon(Icons.book),
                  title: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Ders Konusu',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      _lesson.title = value;
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
                    leading: Icon(Icons.book),
                    title: FutureBuilder<Iterable<Education>>(
                      future: _educations(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text(snapshot.hasError
                              ? snapshot.error.toString()
                              : "Yükleniyor..");
                        }
                        final value = snapshot.data;
                        return DropdownButton<Education>(
                          value: _lesson.educationId != null
                              ? value.firstWhere((element) =>
                                  element.id == _lesson.educationId)
                              : value.first,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (Education newValue) {
                            setState(() {
                              _lesson.educationId = newValue.id;
                            });
                          },
                          items: value.map<DropdownMenuItem<Education>>(
                              (Education value) {
                            return DropdownMenuItem<Education>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                        );
                      },
                    )),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Material(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: EdgeInsets.only(left: 12.0),
                child: ListTile(
                  leading: Icon(Icons.merge_type),
                  title: TextFormField(
                    onChanged: (description) {
                      _lesson.description = description;
                    },
                    decoration: InputDecoration(
                      hintText: 'Açıklama',
                      border: InputBorder.none,
                    ),
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
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      initialDatePickerMode: DatePickerMode.day,
                      firstDate: DateTime(2015),
                      lastDate: DateTime(2101),
                    ).then((date) {
                      return showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((time) => DateTime(date.year, date.month,
                              date.day, time.hour, time.minute));
                    }).then((value) => setState(() {
                          _lesson.startDate = value;
                        }));
                  },
                  leading: Icon(Icons.date_range),
                  title: Text(_lesson.startDate != null
                      ? resources.datetime(_lesson.startDate)
                      : "Başlangıç Tarihi"),
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
                  leading: Icon(FontAwesomeIcons.clock),
                  title: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ders Süresi',
                      border: InputBorder.none,
                    ),
                    onChanged: (duration) {
                      _lesson.duration = int.parse(duration);
                    },
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
