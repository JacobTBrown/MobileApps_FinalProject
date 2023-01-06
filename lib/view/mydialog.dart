import 'package:flutter/material.dart';

class MyDialog {
  static void info({
    BuildContext context,
    String title,
    String message,
    Function action,
    }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(  
          //backgroundColor: Colors.lime,
          title: Container(
            child: Text(title)),
          content: Text(message),
          actions: <Widget>[
            RaisedButton(
              child: Text('OK', style: TextStyle(color: Colors.white)),
              onPressed: action,
            ),
          ]
        );
      }
    );
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => 
        Center(child: CircularProgressIndicator())
    );
  }

  static void popProgressBar(BuildContext context) {
    Navigator.pop(context);
  }
}