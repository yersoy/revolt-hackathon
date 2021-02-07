import 'package:flutter/material.dart';
import 'package:revolt/services.dart';

class Utils {
  static Future loadingFuture() async {
    await Services().initialize();
  }

  void showInSnackBar(String value, context, _scaffoldKey, String message) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 6),
    ));
  }
}
