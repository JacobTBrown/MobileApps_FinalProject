import 'package:flutter/material.dart';

import './view/loginpage.dart';
import './model/theme.dart';

void main() => runApp(CMDApp());

class CMDApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CMDAppState();
  }
}

class CMDAppState extends State<CMDApp> {
  ThemeData themeData;

  CMDAppState() {
    Themes.setMainTheme('Survival');
    Themes.setCardTheme('Survival');
    Themes.setCardThemeData();
    themeData = Themes.mainThemeData;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: themeData,
    );
  }
}