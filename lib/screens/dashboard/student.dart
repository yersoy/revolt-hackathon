import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import '../../utils.dart';
import '../../models.dart';

class Student extends StatefulWidget {
  Student({Key key}) : super(key: key);

  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  List<Education>  _educations = List();
  Position _position;

  Widget _subjects() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:18.0),
                child: Text('Öğrenebileceğiniz konular'),
              ),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {

                  })

            ],
          ),
          Column(
              children: _educations.map((x) {
                return _subjectsTile(x);
              }).toList()),

        ],
      ),
    );
  }

  Widget _subjectsTile(Education model) {
    final theme = Theme.of(context), text = theme.textTheme;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: Colors.black12,
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: Colors.black12,
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          // leading: ClipRRect(
          //   borderRadius: BorderRadius.all(Radius.circular(13)),
          //   child: Container(
          //     height: 45,
          //     width: 45,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       color: Colors.transparent,
          //     ),
          //     child: Image.asset(
          //       model.image,
          //       height: 15,
          //       width: 30,
          //       fit: BoxFit.fitHeight,
          //     ),
          //   ),
          // ),
          title: Text(model.name, style: text.headline3),
          // subtitle: Text(model.usage,
          //   style: TextStyles.titleMedium,
          // ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          _subjects(),
        ],
      ),
    );
  }
}

