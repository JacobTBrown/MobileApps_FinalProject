import 'package:CMD/model/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../model/cardmodel.dart';
import '../controller/adminhomepage_controller.dart';

class AdminHomePage extends StatefulWidget {
  final User user;
  final List<User> userList;
  final List<CardModel> storeCardList;

  AdminHomePage(this.user, this.userList, this.storeCardList);

  @override
  State<StatefulWidget> createState() {
    return AdminHomePageState(user, userList, storeCardList);
  }
}

class AdminHomePageState extends State<AdminHomePage> {
  User user;
  CardModel temp;
  List<User> userList;
  List<CardModel> storeCardList;
  List<int> deleteIndices;

  AdminHomePageController controller;
  BuildContext context;

  AdminHomePageState(this.user, this.userList, this.storeCardList) {
    controller = AdminHomePageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Admin Home'),
            actions: deleteIndices == null
                ? null
                : <Widget>[
                    FlatButton.icon(
                      label: Text('Create'),
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    )
                  ],
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(user.displayName),
                  accountEmail: Text(user.email),
                  currentAccountPicture: Container(
                    color: Colors.black45,
                          margin: EdgeInsets.all(10),
                    child: CachedNetworkImage(
                      imageUrl: "${user.profileImage}",
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),
                    ),
                  ),
                ),
                Container(
                  color: Themes.mainLightAccent,
                  margin: EdgeInsets.only(bottom: 3),
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Sign Out'),
                    onTap: controller.signOut,
                  ),
                )
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Themes.mainDarkAccent,
                  child: Text('Registered Accounts'),
                  onPressed: controller.registeredAccountsPage,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Themes.mainDarkAccent,
                  child: Text('Card Database'),
                  onPressed: controller.getCardStore,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Themes.mainDarkAccent,
                  child: Text('Suggestions'),
                  onPressed: controller.suggestionsPage,
                ),
              )
            ],
          )),
    );
  }
}
