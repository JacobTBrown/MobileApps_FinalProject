import 'package:CMD/model/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controller/comparewithfriendpage_controller.dart';
import '../model/user.dart';

class CompareWithFriendPage extends StatefulWidget {
  final User user;
  final User userFriend;

  CompareWithFriendPage(this.user, this.userFriend);

  @override
  State<StatefulWidget> createState() {
    return CompareWithFriendPageState(user, userFriend);
  }
}

class CompareWithFriendPageState extends State<CompareWithFriendPage> {
  CompareWithFriendPageController controller;
  BuildContext context;
  User user;
  User userFriend;

  TextStyle labelStyle, textStyle;

  CompareWithFriendPageState(this.user, this.userFriend) {
    controller = CompareWithFriendPageController(this);

    labelStyle = TextStyle(
        color: Themes.main, fontSize: 16, fontWeight: FontWeight.w600);
    textStyle =
        TextStyle(color: Themes.mainLightShade, fontWeight: FontWeight.w400);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        color: Color.fromRGBO(55, 55, 55, 1),
        padding: EdgeInsets.all(5),
        child: ListView(children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          height: 150,
                          width: 150,
                          imageUrl: "${user.profileImage}",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline),
                        ),
                      ),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Account Created:', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Text('\t\t\t\t${user.createdOn}', style: textStyle,),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Display Name:', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Text('\t\t\t\t${user.displayName}', style: textStyle,),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Country:', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Text('\t\t\t\t${user.country}', style: textStyle,),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('State:', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Text('\t\t\t\t${user.state}', style: textStyle,),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child:
                              Text('Time Played:', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child:
                              Text('\t\t\t\t${user.timePlayed}', style: textStyle,),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Rank:', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Text('\t\t\t\t${user.ranking}', style: textStyle,),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('# of Friends:', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Text('\t\t\t\t${user.numFriends}', style: textStyle,),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('# of Cards:', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Text('\t\t\t\t${user.numCards}', style: textStyle,),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('# of Decks:', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerRight,
                          child: Text('\t\t\t\t${user.numDecks}', style: textStyle,),
                        ),
                      ]),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: VerticalDivider(
                  color: Colors.white,
                  thickness: 5,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          height: 150,
                          width: 150,
                          imageUrl: "${userFriend.profileImage}",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline),
                        ),
                      ),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text('\t\t\t\t${userFriend.createdOn}', style: textStyle,),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '\t\t\t\t${userFriend.displayName}', style: textStyle),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text('\t\t\t\t${userFriend.country}', style: textStyle),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text('\t\t\t\t${userFriend.state}', style: textStyle),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child:
                              Text('', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child:
                              Text('\t\t\t\t${userFriend.timePlayed}', style: textStyle),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text('\t\t\t\t${userFriend.ranking}', style: textStyle),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '\t\t\t\t${userFriend.numFriends}', style: textStyle),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text('\t\t\t\t${userFriend.numCards}', style: textStyle),
                        ),
                      ]),
                      Column(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('', style: labelStyle,),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text('\t\t\t\t${userFriend.numDecks}', style: textStyle),
                        ),
                      ]),
                    ],
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}
