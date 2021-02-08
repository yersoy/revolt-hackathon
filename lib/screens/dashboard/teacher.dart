import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../../models.dart';
import '../../services.dart';
import '../../utils.dart';

import '../classroom.dart';
import '../classroom/details.dart';

class Teacher extends StatefulWidget {
  Teacher({Key key}) : super(key: key);

  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  Position _position;
  Iterable<Education> _educations;

  Marker _markerItem(Lesson _lesson) {
    Map<String, Color> eduColor = {
      "38tgXMl16Ul2VPxn4uvb": Colors.blue,
      "Ssp5LWwwIycMr3OYg1fV": Colors.red
    };
    Map<String, String> eduText = {
      "38tgXMl16Ul2VPxn4uvb": "Fizik",
      "Ssp5LWwwIycMr3OYg1fV": "Mat"
    };
    return Marker(
      width: 51.0,
      height: 51.0,
      point: LatLng(_lesson.location.latitude, _lesson.location.longitude),
      builder: (context) => Container(
        child: Column(
          children: [
            Text(eduText[_lesson.educationId]),
            Icon(
              FontAwesomeIcons.mapMarkerAlt,
              color: eduColor[_lesson.educationId],
              size: 35,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Services().educations().all().then((value) => _educations = value);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          child: Stack(
            children: [
              Positioned.fill(
                child: FutureBuilder(
                  future: Future.wait([
                    Utils.determinePosition(),
                    Services().lessons().all().then((value) {
                      List<Marker> mymarkers = new List<Marker>();
                      value.forEach((element) {
                        mymarkers.add(_markerItem(element));
                      });
                      return mymarkers;
                    })
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      LatLng mylocation = LatLng(snapshot.data[0].latitude,
                          snapshot.data[0].longitude);

                      return FlutterMap(
                        options: MapOptions(
                          center: mylocation,
                          zoom: 13.0,
                          plugins: [
                            MarkerClusterPlugin(),
                          ],
                        ),
                        layers: [
                          MarkerClusterLayerOptions(
                            maxClusterRadius: 120,
                            size: Size(40, 40),
                            fitBoundsOptions: FitBoundsOptions(
                              padding: EdgeInsets.all(50),
                            ),
                            markers: snapshot.data[1],
                            polygonOptions: PolygonOptions(
                                borderColor: Colors.blueAccent,
                                color: Colors.black12,
                                borderStrokeWidth: 3),
                            builder: (context, markers) {
                              return FloatingActionButton(
                                child: Text(markers.length.toString()),
                                onPressed: null,
                              );
                            },
                          ),
                          TileLayerOptions(
                              urlTemplate:
                                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: ['a', 'b', 'c']),
                          MarkerLayerOptions(markers: snapshot.data[1]),
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
        Card(
          child: Column(
            children: [
              ListTile(
                trailing: Icon(FontAwesomeIcons.graduationCap),
                title: Text("Yakınlardaki Dersler"),
              ),
              Container(
                width: double.infinity,
                height: 300,
                child: FutureBuilder<Iterable<Lesson>>(
                  future: Services().lessons().all(),
                  builder: (context, snapshot) {
                    print(snapshot.error.toString());
                    if (snapshot.hasData) {
                      var data = snapshot.data;
                      print(data.length);
                      if (data.length > 0) {
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              Lesson _lesson = data.elementAt(index);
                              return ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.LESSON,
                                      arguments: _lesson);
                                },
                                title: Text(_lesson.title),
                                trailing:
                                    Text(_lesson.duration.toString() + " DK"),
                                subtitle: Text(_educations
                                    .firstWhere((element) =>
                                        element.id == _lesson.educationId)
                                    .name),
                              );
                            });
                      }
                    }
                    return Center(
                      child: Container(
                        width: 100,
                        child: FlareActor(
                          "assets/flare/logo.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: "idle",
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
