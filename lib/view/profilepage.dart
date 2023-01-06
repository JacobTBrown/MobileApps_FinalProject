import 'package:flutter/material.dart';

import '../controller/profilepage_controller.dart';
import '../model/user.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage(this.user);

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState(user);
  }
}

class ProfilePageState extends State<ProfilePage> {
  ProfilePageController controller;
  BuildContext context;
  User user;

  var formKey = GlobalKey<FormState>();
  var textEdit = new TextEditingController();

  ProfilePageState(this.user) {
    controller = ProfilePageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    //TextStyle style = TextStyle(fontSize: 20, color: Colors.blue[500]);
    //TextStyle hstyle = TextStyle(fontSize: 25, color: Colors.blue[900]);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        color: Color.fromRGBO(55, 55, 55, 1),
        padding: EdgeInsets.all(5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: false,
                    children: <Widget>[
                      Container(
                        color: Colors.white24,
                        height: 100,
                        alignment: Alignment.center,
                        child: Text('Profile Info', style: TextStyle(fontSize: 26,),
                            textAlign: TextAlign.center,
                          ),
                      ),
                      Container(
                        color: Colors.white70,
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              initialValue: user.displayName,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: 'Display Name',
                                labelText: 'Display Name',
                              ),
                              validator: controller.validateDisplayName,
                              onSaved: controller.saveDisplayName,
                            ),
                            TextFormField(
                              initialValue: user.profileImage,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: 'Image URL',
                                labelText: 'Image URL',
                              ),
                              validator: controller.validateImageURL,
                              onSaved: controller.saveImageURL,
                            ),
                            TextFormField(
                              initialValue: user.email,
                              autocorrect: false,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: 'Email (as login name)',
                                labelText: 'Email',
                              ),
                              validator: controller.validateEmail,
                              onSaved: controller.saveEmail,
                            ),
                            TextFormField(
                              autocorrect: false,
                              obscureText: true,
                              controller: textEdit,
                              decoration: InputDecoration(
                                hintText: 'Current Password',
                                labelText: 'Current Password',
                              ),
                              validator: controller.validateCurrentPassword,
                              onSaved: controller.saveCurrentPassword,
                            ),
                            TextFormField(
                              autocorrect: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                labelText: 'New Password',
                              ),
                              validator: controller.validateNewPassword,
                              onSaved: controller.saveNewPassword,
                            ),
                            TextFormField(
                              initialValue: user.country,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: 'Country',
                                labelText: 'Country',
                              ),
                              validator: controller.validateCountry,
                              onSaved: controller.saveCountry,
                            ),
                            TextFormField(
                              initialValue: user.state,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: 'State',
                                labelText: 'State',
                              ),
                              validator: controller.validateState,
                              onSaved: controller.saveState,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  child: Text('Update Account'),
                                  onPressed: controller.updateAccount,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
