import 'package:flutter/material.dart';

import '../view/registerpage.dart';
import './myfirebase.dart';
import '../view/mydialog.dart';

class RegisterPageController {

  RegisterPageState state;

  RegisterPageController(this.state);

  String otherPassword = '';

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter valid email address';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validatePassword(String value) {
    if (value == null || value == '') {
      return 'Enter valid password';
    } else if (value.length < 6) {
      return 'Password cannot be < 6';
    }
    otherPassword = value;
    return null;
  }

  void saveOtherPassword(String value) {
  }

  String validateSamePassword(String value) {
    if (value != otherPassword || value == '') {
      return 'Enter same password';
    } else if (value.length < 6) {
      return 'Password cannot be < 6';
    }
    return null;
  }

  void saveSamePassword(String value) {
    state.user.password = value;
  }

  String validateDisplayName(String value) {
    if (value == null || value.length < 4) {
      return 'Enter a display name with at least 4 chars';
    }
    return null;
  }

  void saveDisplayName(String value) {
    state.user.displayName = value;
  }

  void createAccount() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    //using email/password: sign up an account at Firebase
    try {
      state.user.uid = await MyFirebase.createAccount(
        email: state.user.email,
        password: state.user.password,
      );
    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Account creation failed!',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );

      return;
    }

    state.user.profileImage = "NONE";
    state.user.createdOn = new DateTime.now().toLocal().toString().substring(0, 10).trim();
    state.user.timePlayed = "0";
    state.user.ranking = "NONE";
    state.user.theme = "Survival";
    state.user.country = "NONE";
    state.user.state = "NONE";
    state.user.numFriends = 0;
    state.user.numCards = 0;
    state.user.numDecks = 0;
    state.user.points = 10;
    state.user.friendsList = <dynamic>[].toList(growable: true);
    state.user.cardsList = <dynamic>[].toList(growable: true);
    state.user.deckNameList = <dynamic>[].toList(growable: true);
    state.user.deckList = new Map<dynamic, dynamic>();

    // create user profile
    try {
      MyFirebase.createProfile(state.user);
    } catch (e) {
      state.user.displayName = null;
      print('error: ' + e.toString());
    }

    MyDialog.info(
      context: state.context,
      title: 'Account created successfully!',
      message: 'Your account is created with ${state.user.email}',
      action: () => {
        (state.user.isAdmin != null || state.user.isAdmin != false) 
        ? {Navigator.pop(state.context, state.user),
        Navigator.pop(state.context, state.user),} 
        : Navigator.pop(state.context),
          Navigator.pop(state.context),
      },
    );
  }
}