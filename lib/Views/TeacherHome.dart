
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:revolt/utils.dart';

class TeacherHome extends StatefulWidget {
    TeacherHome({Key key}) : super(key: key);

  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  Position myposition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            child: Stack(
              children: [
                Positioned.fill(
                  child: FutureBuilder<Position>(
                    future: Utils.determinePosition(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        LatLng mylocation = LatLng(
                            snapshot.data.latitude, snapshot.data.longitude);
                        var markers = [
                          Marker(
                            width: 40.0,
                            height: 40.0,
                            point: mylocation,
                            builder: (ctx) => Container(
                              child: Image.asset(
                                "assets/images/location-pin.png",
                              ),
                            ),
                          ),
                        ];

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
        ],
      ),
    );
  }
}
