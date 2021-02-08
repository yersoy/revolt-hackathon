import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geolocator/geolocator.dart';

import 'package:latlong/latlong.dart';
import 'package:revolt/i18n.dart';

import '../Auth.dart';
import '../convert.dart';

import '../models.dart';
import '../services.dart';
import '../utils.dart';

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

  Marker _markerItem(LatLng location) {
    return Marker(
      width: 40.0,
      height: 40.0,
      point: location,
      builder: (context) => Container(
        child: Icon(FontAwesomeIcons.mapMarker),
      ),
    );
  }

  setLocation() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konum Seçiniz'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 250,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: FutureBuilder(
                          future: Future.wait([
                            Utils.determinePosition(),
                          ]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              LatLng mylocation = LatLng(
                                  snapshot.data[0].latitude,
                                  snapshot.data[0].longitude);
                              List<Marker> markers = [_markerItem(mylocation)];
                              return FlutterMap(
                                options: MapOptions(
                                  onTap: (location) {
                                    mylocation = location;
                                  },
                                  center: mylocation,
                                  zoom: 13.0,
                                ),
                                layers: [
                                  TileLayerOptions(
                                      urlTemplate:
                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      subdomains: ['a', 'b', 'c']),
                                  MarkerLayerOptions(markers: markers),
                                ],
                              );
                            }
                            return Card();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Gönder'),
              onPressed: () {
                final snackBar =
                    SnackBar(content: Text('Öğrenciler Bilgilendirildi !'));
              },
            ),
          ],
        );
      },
    );
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
          Services()
              .lessons()
              .save(_lesson)
              .then((value) => Navigator.pop(context));
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
          Container(
            padding: EdgeInsets.all(12.0),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.withOpacity(0.2),
              child: Container(
                padding: EdgeInsets.only(left: 12.0),
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.locationArrow),
                  title: FutureBuilder(
                    future: Utils.determinePosition(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Position myloc = snapshot.data;
                        _lesson.location =
                            new GeoPoint(myloc.latitude, myloc.longitude);

                        return FutureBuilder<String>(
                          future: Utils.getAdressbyCoordinats(myloc),
                          builder: (context, snapshott) {
                            if (snapshott.hasData) return Text(snapshott.data);
                            return Text("Yükleniyor..");
                          },
                        );
                      }
                      return Text("Yükleniyor..");
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
