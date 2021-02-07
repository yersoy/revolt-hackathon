import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:revolt/theme.dart';


class AuthCase extends StatefulWidget {
  AuthCase({Key key}) : super(key: key);

  @override
  _AuthCaseState createState() => _AuthCaseState();
}



class _AuthCaseState extends State<AuthCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.black,
        body: Stack(
          children: <Widget>[

            Positioned.fill(
              child:
              FlutterMap(
                options: MapOptions(
                  center: LatLng(41.066632, 28.995215),
                  zoom:14.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.0632, 28.99),
                        builder: (ctx) =>
                            Container(
                              child: Image.asset("assets/images/location-pin.png"),
                            ),
                      ),
                      Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.066756, 29.002210),
                        builder: (ctx) =>
                            Container(
                              child: Image.asset("assets/images/location-pin.png"),
                            ),
                      ),  Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.073430, 28.994607),
                        builder: (ctx) =>
                            Container(
                              child: Image.asset("assets/images/location-pin.png"),
                            ),
                      ),Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.078114, 28.985561),
                        builder: (ctx) =>
                            Container(
                              child: Image.asset("assets/images/location-pin.png"),
                            ),
                      ),Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.073428, 29.007685),
                        builder: (ctx) =>
                            Container(
                              child:  Image.asset("assets/images/location-pin.png"),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Opacity(
                opacity: .4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [ThemeColor.lightBlue,ThemeColor.accentBlue],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        tileMode: TileMode.mirror,
                        stops: [1.05, 3]),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 2.9,
              right: 2.0,
              top: 45,
              bottom: 20,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:35,bottom: 354),
                    child: Image.asset(
                      'assets/images/logo.png',height: 140,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Theme.of(context).primaryColor,
                      elevation: 0.0,
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, '/login');
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Oturum Aç",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Theme.of(context).primaryColor,
                      elevation: 0.0,
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, '/register');
                        },
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          "Kayıt Ol",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
}





