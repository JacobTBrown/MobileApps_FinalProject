import 'package:flutter/material.dart';

class Themes {
  static Color defaultC = Colors.black;

  static Color red = Color.fromRGBO(235, 62, 62, 1);
  static Color redLightAccent = Color.fromRGBO(224, 142, 125, 1);
  static Color redLightShade = Color.fromRGBO(244, 238, 232, 1);
  static Color redDarkAccent = Color.fromRGBO(139, 144, 145, 1);
  static Color redDarkShade = Color.fromRGBO(41, 38, 47, 1);

  static Color orange = Color.fromRGBO(240, 122, 52, 1);
  static Color orangeLightAccent = Color.fromRGBO(210, 119, 110, 1);
  static Color orangeLightShade = Color.fromRGBO(250, 244, 232, 1);
  static Color orangeDarkAccent = Color.fromRGBO(169, 93, 64, 1);
  static Color orangeDarkShade = Color.fromRGBO(42, 50, 54, 1);

  static Color purple = Color.fromRGBO(170, 58, 210, 1);
  static Color purpleLightAccent = Color.fromRGBO(187, 146, 209, 1);
  static Color purpleLightShade = Color.fromRGBO(239, 226, 245, 1);
  static Color purpleDarkAccent = Color.fromRGBO(136, 125, 169, 1);
  static Color purpleDarkShade = Color.fromRGBO(39, 35, 77, 1);

  static Color blue = Color.fromRGBO(59, 135, 222, 1);
  static Color blueLightAccent = Color.fromRGBO(125, 188, 224, 1);
  static Color blueLightShade = Color.fromRGBO(237, 245, 255, 1);
  static Color blueDarkAccent = Color.fromRGBO(90, 124, 201, 1);
  static Color blueDarkShade = Color.fromRGBO(42, 61, 118, 1);

  static Color green = Color.fromRGBO(78, 168, 57, 1);
  static Color greenLightAccent = Color.fromRGBO(130, 176, 148, 1);
  static Color greenLightShade = Color.fromRGBO(237, 245, 226, 1);
  static Color greenDarkAccent = Color.fromRGBO(115, 129, 113, 1);
  static Color greenDarkShade = Color.fromRGBO(36, 46, 36, 1);

  static Color yellow = Color.fromRGBO(238, 182, 58, 1);
  static Color yellowLightAccent = Color.fromRGBO(170, 160, 108, 1);
  static Color yellowLightShade = Color.fromRGBO(240, 244, 223, 1);
  static Color yellowDarkAccent = Color.fromRGBO(179, 127, 92, 1);
  static Color yellowDarkShade = Color.fromRGBO(94, 76, 81, 1);

  static Map<Color, String> mainColorList = <Color, String>{
    red: 'Power',
    orange: 'Survival',
    purple: 'Nobility',
    blue: 'Diplomacy',
    green: 'Growth',
    yellow: 'Faith'
  };
  static Map<Color, String> mainColorLightList = <Color, String>{
    red: 'Power',
    orange: 'Survival',
    purple: 'Nobility',
    blue: 'Diplomacy',
    green: 'Growth',
    yellow: 'Faith'
  };

  static ThemeData mainThemeData;
  static ThemeData cardThemeData;

  static Color main;
  static Color mainLightAccent;
  static Color mainLightShade;
  static Color mainDarkAccent;
  static Color mainDarkShade;

  static Color card;
  static Color cardLightAccent;
  static Color cardLightShade;
  static Color cardDarkAccent;
  static Color cardDarkShade;

  static TextStyle title;
  static ImageProvider<dynamic> border;

  static Color getCardColoring(String type) {
    switch (type) {
      case "Power":
        return red;
        break;
      case "Survival":
        return orange;
        break;
      case "Nobility":
        return purple;
        break;
      case "Diplomacy":
        return blue;
        break;
      case "Growth":
        return green;
        break;
      case "Faith":
        return yellow;
        break;
      default:
        return Colors.black;
        break;
    }
  }

  static void setMainThemeData() {
    mainThemeData = ThemeData(
      primaryColor: Themes.main,
      primaryColorDark: Themes.mainDarkAccent,
      primaryColorLight: Themes.mainLightAccent,
      canvasColor: Themes.mainDarkShade,
      dialogTheme: DialogTheme(
          backgroundColor: Themes.mainDarkShade,
          contentTextStyle: TextStyle(color: Themes.mainLightShade)),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Themes.main, fontWeight: FontWeight.w600),
        hintStyle: TextStyle(color: Themes.mainDarkAccent, fontWeight: FontWeight.w400),
        counterStyle: TextStyle(color: Themes.mainDarkShade, fontWeight: FontWeight.w600),
        helperStyle: TextStyle(color: Themes.mainDarkShade, fontWeight: FontWeight.w600),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Themes.main, foregroundColor: Themes.mainDarkShade),
      appBarTheme: AppBarTheme(
        color: Themes.main,
      ),
      iconTheme: IconThemeData(
        color: Themes.mainDarkShade,
      ),
      primaryIconTheme: IconThemeData(
        color: Themes.mainDarkShade,
      ),
      textTheme: TextTheme(
        title: TextStyle(
            color: Themes.main, letterSpacing: 3, fontWeight: FontWeight.w900),
        subtitle: TextStyle(
            color: Themes.main, letterSpacing: 1, fontWeight: FontWeight.w700),
        overline: TextStyle(color: Themes.main, fontWeight: FontWeight.w600),
        headline: TextStyle(color: Themes.main, fontWeight: FontWeight.w600),
        body1: TextStyle(color: Themes.mainLightShade),
        subhead: TextStyle(color: Themes.mainDarkAccent, fontWeight: FontWeight.w800),
        button:
            TextStyle(color: Themes.mainDarkShade, fontWeight: FontWeight.w500),
      ),
    );
  }

  static void setCardThemeData() {
    cardThemeData = ThemeData(
      primaryColor: Themes.card,
      primaryColorDark: Themes.cardDarkAccent,
      primaryColorLight: Themes.cardLightAccent,
      canvasColor: Themes.cardDarkShade,
      dialogTheme: DialogTheme(
          backgroundColor: Themes.cardDarkShade,
          contentTextStyle: TextStyle(color: Themes.cardLightShade)),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: Themes.cardLightAccent, fontWeight: FontWeight.w600),
        hintStyle: TextStyle(color: Themes.card, fontWeight: FontWeight.w600),
        focusColor: Themes.main,
        counterStyle:
            TextStyle(color: Themes.card, fontWeight: FontWeight.w600),
        helperStyle: TextStyle(color: Themes.card, fontWeight: FontWeight.w600),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Themes.card, foregroundColor: Themes.cardDarkShade),
      appBarTheme: AppBarTheme(
        color: Themes.card,
      ),
      iconTheme: IconThemeData(
        color: Themes.cardDarkShade,
      ),
      primaryIconTheme: IconThemeData(
        color: Themes.cardDarkShade,
      ),
      textTheme: TextTheme(
        title: TextStyle(
            color: Themes.card, letterSpacing: 3, fontWeight: FontWeight.w900),
        subtitle: TextStyle(
            color: Themes.card, letterSpacing: 1, fontWeight: FontWeight.w700),
        overline: TextStyle(color: Themes.card, fontWeight: FontWeight.w600),
        headline: TextStyle(color: Themes.card, fontWeight: FontWeight.w600),
        body1: TextStyle(color: Themes.cardLightShade),
        subhead: TextStyle(color: Themes.card, fontWeight: FontWeight.w800),
        button:
            TextStyle(color: Themes.cardDarkShade, fontWeight: FontWeight.w500),
      ),
    );
  }

  static void setMainTheme(String type) {
    switch (type) {
      case "Power":
        main = red;
        mainLightAccent = redLightAccent;
        mainLightShade = redLightShade;
        mainDarkAccent = redDarkAccent;
        mainDarkShade = redDarkShade;
        break;
      case "Survival":
        main = orange;
        mainLightAccent = orangeLightAccent;
        mainLightShade = orangeLightShade;
        mainDarkAccent = orangeDarkAccent;
        mainDarkShade = orangeDarkShade;
        break;
      case "Nobility":
        main = purple;
        mainLightAccent = purpleLightAccent;
        mainLightShade = purpleLightShade;
        mainDarkAccent = purpleDarkAccent;
        mainDarkShade = purpleDarkShade;
        break;
      case "Diplomacy":
        main = blue;
        mainLightAccent = blueLightAccent;
        mainLightShade = blueLightShade;
        mainDarkAccent = blueDarkAccent;
        mainDarkShade = blueDarkShade;
        break;
      case "Growth":
        main = green;
        mainLightAccent = greenLightAccent;
        mainLightShade = greenLightShade;
        mainDarkAccent = greenDarkAccent;
        mainDarkShade = greenDarkShade;
        break;
      case "Faith":
        main = yellow;
        mainLightAccent = yellowLightAccent;
        mainLightShade = yellowLightShade;
        mainDarkAccent = yellowDarkAccent;
        mainDarkShade = yellowDarkShade;
        break;
      default:
        main = Colors.grey[350];
        mainLightAccent = Colors.grey[50];
        mainLightShade = Colors.white54;
        mainDarkAccent = Colors.black54;
        mainDarkShade = Colors.black;
        break;
    }

    setMainThemeData();
  }

  static void setCardTheme(String type) {
    switch (type) {
      case "Power":
        card = red;
        cardLightAccent = redLightAccent;
        cardLightShade = redLightShade;
        cardDarkAccent = redDarkAccent;
        cardDarkShade = redDarkShade;
        border = Image(image: AssetImage('assets/power_border.png'),).image;
        break;
      case "Survival":
        card = orange;
        cardLightAccent = orangeLightAccent;
        cardLightShade = orangeLightShade;
        cardDarkAccent = orangeDarkAccent;
        cardDarkShade = orangeDarkShade;
        border = Image(image: AssetImage('assets/survival_border.png'),).image;
        break;
      case "Nobility":
        card = purple;
        cardLightAccent = purpleLightAccent;
        cardLightShade = purpleLightShade;
        cardDarkAccent = purpleDarkAccent;
        cardDarkShade = purpleDarkShade;
        border = Image(image: AssetImage('assets/nobility_border.png'),).image;
        break;
      case "Diplomacy":
        card = blue;
        cardLightAccent = blueLightAccent;
        cardLightShade = blueLightShade;
        cardDarkAccent = blueDarkAccent;
        cardDarkShade = blueDarkShade;
        border = Image(image: AssetImage('assets/diplomacy_border.png'),).image;
        break;
      case "Growth":
        card = green;
        cardLightAccent = greenLightAccent;
        cardLightShade = greenLightShade;
        cardDarkAccent = greenDarkAccent;
        cardDarkShade = greenDarkShade;
        border = Image(image: AssetImage('assets/growth_border.png'),).image;
        break;
      case "Faith":
        card = yellow;
        cardLightAccent = yellowLightAccent;
        cardLightShade = yellowLightShade;
        cardDarkAccent = yellowDarkAccent;
        cardDarkShade = yellowDarkShade;
        border = Image(image: AssetImage('assets/faith_border.png'),).image;
        break;
      default:
        card = Colors.grey[350];
        cardLightAccent = Colors.grey[50];
        cardLightShade = Colors.white54;
        cardDarkAccent = Colors.black54;
        cardDarkShade = Colors.black;
        border = Image(image: AssetImage('assets/faith_border.png'),).image;
        break;
    }
  }
}
