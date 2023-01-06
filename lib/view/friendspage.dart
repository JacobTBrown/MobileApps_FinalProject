import 'package:flutter/material.dart';

import '../controller/friendspage_controller.dart';
import '../model/user.dart';

class FriendsPage extends StatefulWidget {
  final User user;

  FriendsPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return FriendsPageState(user);
  }
}

class FriendsPageState extends State<FriendsPage> {
  FriendsPageController controller;
  BuildContext context;
  User user;

  var formKey = GlobalKey<FormState>();

  var textEdit = new TextEditingController();

  FriendsPageState(this.user) {
    controller = FriendsPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
      ),
      body: Container(
        color: Color.fromRGBO(55, 55, 55, 1),
        padding: EdgeInsets.all(5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: Colors.white24,
                height: 100,
                alignment: Alignment.center,
                child: Text(
                  'Friends List',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                  key: formKey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: textEdit,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: "Enter a user's display name",
                            labelText: 'Search Users',
                          ),
                          validator: controller.validateUser,
                          onSaved: controller.saveUser,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        hoverColor: Colors.orange,
                        onPressed: controller.addFriend,
                      )
                    ],
                  )),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: user.friendsList.length,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.all(16),
                                color: Colors.white10,
                                child: Text('${user.friendsList[index]}'))),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          color: Colors.white30,
                          child: IconButton(
                            icon: Icon(Icons.compare),
                            onPressed: () {
                              controller.compareWithFriend(user.friendsList[index]);
                            },
                          ),
                        ),
                        Container(
                          color: Colors.white30,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              controller.deleteFriend(user.friendsList[index]);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
