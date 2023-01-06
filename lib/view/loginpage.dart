import 'package:flutter/material.dart';

import '../controller/loginpage_controller.dart';
import '../model/user.dart';
import '../model/theme.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  LoginPageController controller;
  BuildContext context;

  User user = User();
  var formKey = GlobalKey<FormState>();

  var _opacity = 0.0;
  var _color = Color.fromRGBO(255, 198, 71, 1);

  LoginPageState() {
    controller = LoginPageController(this);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  void startAnimations() {
    setState(() {
      _opacity = _opacity == 0 ? 1.0 : 0;
      print(_opacity);

      _color = _color == Color.fromRGBO(255, 198, 71, 1)
          ? Color.fromRGBO(246, 75, 75, 1.0)
          : Color.fromRGBO(255, 198, 71, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    startAnimations();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Themes.mainDarkShade,
            ),
            label: Text('Register'),
            onPressed: controller.createAccount,
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'C',
                          style: TextStyle(fontSize: 36, color: Colors.white),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 1800),
                          opacity: _opacity,
                          child: Container(
                              padding: EdgeInsets.only(top: 13),
                              child: Text(
                                'hampions',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'M',
                          style: TextStyle(fontSize: 36, color: Colors.white),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 1800),
                          opacity: _opacity,
                          child: Container(
                              padding: EdgeInsets.only(top: 13),
                              child: Text(
                                'onsters',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'D',
                          style: TextStyle(fontSize: 36, color: Colors.white),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 1800),
                          opacity: _opacity,
                          child: Container(
                              padding: EdgeInsets.only(top: 13),
                              child: Text(
                                'ragons',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(15),
              
              child: Form(
                key: formKey,
                child: ListView(shrinkWrap: true, children: <Widget>[
                  TextFormField(
                    initialValue: user.email,
                    decoration: InputDecoration(
                      labelText: 'Enter email',
                      hintText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                    onSaved: controller.saveEmail,
                  ),
                  TextFormField(
                    initialValue: user.password,
                    decoration: InputDecoration(
                      labelText: 'Enter password',
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: controller.validatePassword,
                    onSaved: controller.savePassword,
                  ),
                  RaisedButton(
                    child: Text('Login'),
                    onPressed: controller.login,
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
