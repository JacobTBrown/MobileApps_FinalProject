import 'package:flutter/material.dart';

import '../controller/registerpage_controller.dart';
import '../model/user.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage();
  
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  RegisterPageController controller;
  BuildContext context;

  User user = User();

  var formKey = GlobalKey<FormState>();

  RegisterPageState() {
    controller = RegisterPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        centerTitle: true,
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
                              initialValue: user.email,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: 'Email (as login name)',
                                labelText: 'Email',
                              ),
                              validator: controller.validateEmail,
                              onSaved: controller.saveEmail,
                            ),
                            TextFormField(
                              initialValue: user.password,
                              autocorrect: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                              ),
                              validator: controller.validatePassword,
                              onSaved: controller.saveOtherPassword,
                            ),
                            TextFormField(
                              initialValue: user.password,
                              autocorrect: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                labelText: 'Confirm Password',
                              ),
                              validator: controller.validateSamePassword,
                              onSaved: controller.saveSamePassword,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  child: Text('Register'),
                                  onPressed: controller.createAccount,
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
