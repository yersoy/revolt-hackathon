import 'dart:math';

import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import '../i18n.dart';
import '../constants.dart';

class Entrance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  final MapController _controller = MapController();
  final List<LatLng> _points = List();

  @override
  void initState() {
    super.initState();

    _controller.onReady.then((e) {
      final bounds = _controller.bounds, vertical = (bounds.north - bounds.south), horizontal = (bounds.east - bounds.west);
      final random = Random();

      setState(() { _points.addAll(List.generate(100, (i) => LatLng((bounds.south + (horizontal * random.nextDouble())), (bounds.west + (vertical * random.nextDouble()))))); });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context), button = theme.buttonTheme;
    final resources = GlobalCustomLocalizations.of(context);

    return Scaffold(
      body: Stack(alignment: Alignment.bottomCenter,
        children: [
          FlutterMap(
            options: MapOptions(
                center: new LatLng(41.071531, 28.8067753),
                zoom: 13.0,
                plugins: [
                  MarkerClusterPlugin(),
                ]
            ),
            layers: [
              TileLayerOptions(maxZoom: 20, opacity: 0.25, retinaMode: true, backgroundColor: Colors.white,
                urlTemplate: 'http://mt{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                subdomains: ['0', '1', '2', '3'],
              ),
              MarkerLayerOptions(
                markers: _points.map((point) => Marker(point: point, width: 6.0, height: 6.0,
                  builder: (context) => Container(
                    decoration: BoxDecoration(color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                )).toList(),
              ),
            ],
            mapController: _controller,
          ),
          Container(color: Colors.transparent),
          Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 72.0, horizontal: 24.0),
                child: Column(
                  children: [
                    Text(resources.get(resources.ENTRANCE_TITLE), style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87)),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(resources.get(resources.ENTRANCE_DESCRIPTION), textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, color: Colors.black54)),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Padding(padding: EdgeInsets.only(right: 8.0, bottom: 12.0, left: 16.0),
                      child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(button.colorScheme.primaryVariant)),
                        child: Text(resources.ENTRANCE_SIGNUP, style: TextStyle(fontSize: 16.0)),
                        onPressed: () { Navigator.pushNamed(context, Routes.SIGNUP); },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(padding: EdgeInsets.only(right: 16.0, bottom: 12.0, left: 8.0),
                      child: ElevatedButton(
                        child: Text(resources.ENTRANCE_SIGNIN, style: TextStyle(fontSize: 16.0)),
                        onPressed: () { Navigator.pushNamed(context, Routes.SIGNIN); },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}