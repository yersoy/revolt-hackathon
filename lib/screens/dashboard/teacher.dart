import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  Marker _markerItem(LatLng location) {
    return Marker(
      width: 40.0,
      height: 40.0,
      point: location,
      builder: (context) => Container(
        child: Image.asset('assets/images/location-pin.png'),
      ),
    );
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
                    Services().get("lessons").get()
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      LatLng mylocation = LatLng(snapshot.data[0].latitude,
                          snapshot.data[0].longitude);
                      List<Marker> markers = [_markerItem(mylocation)];
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
                            markers: markers,
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
        Card(
          child: Column(
            children: [
              ListTile(
                trailing: Icon(FontAwesomeIcons.graduationCap),
                title: Text("Ders Sınıfı İstekleri"),
              ),
              Container(
                width: double.infinity,
                height: 300,
                child: FutureBuilder<QuerySnapshot>(
                  future: Services().get("lessons").get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var data = snapshot.data.docs;
                      if (snapshot.data.docs.length > 0) {
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Details(
                                        classid: data.elementAt(index)["id"],
                                      ),
                                    ),
                                  );
                                },
                                title:
                                    Text(data.elementAt(index)["lessonName"]),
                                trailing: Text(data
                                        .elementAt(index)["lessonDuration"]
                                        .toString() +
                                    " DK"),
                                subtitle:
                                    Text(data.elementAt(index)["lessonType"]),
                              );
                            });
                      }
                      return Center(
                        child: Text("Yakınlarda Ders Bulunamadı"),
                      );
                    }
                    return Container(
                      width: double.infinity,
                      height: 200,
                      child: FlareActor(
                        "assets/flare/logo.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: "idle",
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
