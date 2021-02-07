import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';
import 'package:revolt/theme.dart';

class AuthCase extends StatefulWidget {
  AuthCase({Key key}) : super(key: key);

  @override
  _AuthCaseState createState() => _AuthCaseState();
}

class _AuthCaseState extends State<AuthCase> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(41.066632, 28.995215),
                  zoom: 14.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.0632, 28.99),
                        builder: (ctx) => Container(
                          child: Image.asset("assets/images/location-pin.png"),
                        ),
                      ),
                      Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.066756, 29.002210),
                        builder: (ctx) => Container(
                          child: Image.asset("assets/images/location-pin.png"),
                        ),
                      ),
                      Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.073430, 28.994607),
                        builder: (ctx) => Container(
                          child: Image.asset("assets/images/location-pin.png"),
                        ),
                      ),
                      Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.078114, 28.985561),
                        builder: (ctx) => Container(
                          child: Image.asset("assets/images/location-pin.png"),
                        ),
                      ),
                      Marker(
                        width: 28.0,
                        height: 28.0,
                        point: LatLng(41.073428, 29.007685),
                        builder: (ctx) => Container(
                          child: Image.asset("assets/images/location-pin.png"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 300,
                  child: FlareActor(
                    "assets/flare/logo.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: "idle",
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        textColor: Colors.blue,
                        child: Text(
                          'Hesabın var mı ? Giriş Yap',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      height: 37,
                      width: MediaQuery.of(context).size.width - 100,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(
                          'Kayıt Ol',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
