import 'package:CMD/controller/myfirebase.dart';
import 'package:CMD/model/cardmodel.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../controller/adminaccountspage_controller.dart';

class AdminAccountsPage extends StatefulWidget {
  final User user;
  final List<User> userList;
  final List<CardModel> storeCardList;

  AdminAccountsPage(this.user, this.userList, this.storeCardList);

  @override
  State<StatefulWidget> createState() {
    return AdminAccountsPageState(user, userList, storeCardList);
  }
}

class AdminAccountsPageState extends State<AdminAccountsPage> {
  AdminAccountsPageController controller;
  BuildContext context;

  User user;
  List<User> userList;
  List<CardModel> storeCardList;

  AdminAccountsPageState(this.user, this.userList, this.storeCardList) {
    controller = AdminAccountsPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
    appBar: AppBar(
      title: Text('Registered Accounts'),
    ),
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: controller.addUser,
    ),
    body: Container(
      margin: EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(16),
                                color: Colors.white10,
                                child: Text('${userList[index].displayName}'))),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          color: Colors.white30,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              controller.editUser(userList[index]);
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white30,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteUser(userList[index]);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
      ),
    ));
  }
}
