import 'dart:async';
import 'package:flutter/material.dart';

import '../theme.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _query;

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ThemeColor.background,
      leading: Container(),
      actions: <Widget>[
        Expanded(
          child: TextField(
              autofocus: true,
              onChanged: (value) { setState(() { _query = value; }); },
              style: new TextStyle(color: Colors.black, fontSize: 20),
              decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Ara',
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.search, color: Colors.black))),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
          Center(child: Image.asset('assets/images/pixeltrue-search-1.png')),

          ]),
        ),
      ),
    );
  }
}
