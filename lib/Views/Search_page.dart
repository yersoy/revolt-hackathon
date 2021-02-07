import 'dart:async';
import 'package:flutter/material.dart';

import '../theme.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _searchTerm;


  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ThemeColor.background,
      leading: Container(),
      actions: <Widget>[
        Expanded(
          child: TextField(
              autofocus: true,
              onChanged: (val) {
                setState(() {
                  _searchTerm = val;
                });
              },
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
