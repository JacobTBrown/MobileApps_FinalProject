import 'package:CMD/view/adminhomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

import '../controller/myfirebase.dart';
import '../view/loginpage.dart';
import '../view/registerpage.dart';
import '../view/mydialog.dart';
import '../view/homepage.dart';
import '../model/user.dart';
import '../model/cardmodel.dart';

class LoginPageController {
  LoginPageState state;
  LoginPageController(this.state);

  SequenceAnimation animSequence;

  /*void setupAnimations() {
    animSequence = SequenceAnimationBuilder()
      .addAnimatable(
        animatable: ColorTween(begin: Color.fromRGBO(246, 75, 75, 1), end: Color.fromRGBO(255, 198, 71, 1)),
        from: const Duration(milliseconds: 0),
        to: const Duration(milliseconds: 500),
        tag: "color",
      ).addAnimatable(
        animatable: ColorTween(begin: Color.fromRGBO(255, 198, 71, 1), end: Color.fromRGBO(255, 140, 71, 1)),
        from: const Duration(milliseconds: 500),
        to: const Duration(milliseconds: 1000),
        tag: "color"
      ).addAnimatable(
        animatable: ColorTween(begin: Color.fromRGBO(255, 140, 71, 1), end: Color.fromRGBO(194, 107, 266, 1)),
        from: const Duration(milliseconds: 1000),
        to: const Duration(milliseconds: 1500),
        tag: "color"
      ).addAnimatable(
        animatable: ColorTween(begin: Color.fromRGBO(194, 107, 266, 1), end: Color.fromRGBO(95, 167, 249, 1)),
        from: const Duration(milliseconds: 1500),
        to: const Duration(milliseconds: 2000),
        tag: "color"
      ).addAnimatable(
        animatable: ColorTween(begin: Color.fromRGBO(95, 167, 249, 1), end: Color.fromRGBO(99, 169, 83, 1)),
        from: const Duration(milliseconds: 2000),
        to: const Duration(milliseconds: 2500),
        tag: "color"
      ).addAnimatable(
        animatable: ColorTween(begin: Color.fromRGBO(99, 169, 83, 1), end: Color.fromRGBO(246, 75, 75, 1)),
        from: const Duration(milliseconds: 2500),
        to: const Duration(milliseconds: 3000),
        tag: "color"
      ).animate(state.animController);

      state.animController.repeat();
  }**/

  void createAccount() {
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(),
        ));
  }

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter valid Email Address';
    }

    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validatePassword(String value) {
    if (value == null || value.length < 6) {
      return 'Enter password';
    }

    return null;
  }

  void savePassword(String value) {
    state.user.password = value;
  }

  void login() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    MyDialog.showProgressBar(state.context);

    try {
      state.user.uid = await MyFirebase.login(
          email: state.user.email, password: state.user.password);
    } catch (e) {
      MyDialog.popProgressBar(state.context);
      MyDialog.info(
        context: state.context,
        title: 'Login Error',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );
      return;
    }

    //login success -> read user profile
    User user;
    try {
      user = await MyFirebase.readProfile(state.user.uid);
      state.user.password = user.password;
      state.user.displayName = user.displayName;
      state.user.profileImage = user.profileImage;
      state.user.createdOn = user.createdOn;
      state.user.timePlayed = user.timePlayed;
      state.user.ranking = user.ranking;
      state.user.country = user.country;
      state.user.state = user.state;
      state.user.theme = user.theme;
      state.user.numFriends = user.numFriends;
      state.user.numCards = user.numCards;
      state.user.numDecks = user.numDecks;
      state.user.points = user.points;
      state.user.friendsList = user.friendsList;

      if (user.isAdmin == null || user.isAdmin == false)
        state.user.isAdmin = false;
      else
        state.user.isAdmin = user.isAdmin;
      
      if (user.cardsList == null || user.cardsList.isEmpty)
        state.user.cardsList = new List<dynamic>().toList(growable: true);
      else
        state.user.cardsList = user.cardsList;
      if (user.deckNameList == null || user.deckNameList.isEmpty)
        state.user.deckNameList = new List<dynamic>().toList(growable: true);
      else
        state.user.deckNameList = user.deckNameList;
      if (user.deckList == null || user.deckList.isEmpty)
        state.user.deckList = new Map<dynamic, dynamic>();
      else
        state.user.deckList = user.deckList;
    } catch (e) {
      // no displayname and zip can be updated
      print('******READPROFILE: ' + e.toString());
    }

    if (user == null) {
      MyDialog.info(
        context: state.context,
        title: 'Login Error',
        message: 'Account not found',
        action: () => {
          MyDialog.popProgressBar(state.context),
          Navigator.pop(state.context)
        },
      );
      return;
    } else {
      // Cards that this user owns
      List<CardModel> storeCardList;
      try {
        storeCardList = await MyFirebase.getStoreCards();
      } catch (e) {
        storeCardList = <CardModel>[];
      }

      List<User> userList;
      if (state.user.isAdmin != null && state.user.isAdmin != false) {
        try {
          userList = await MyFirebase.getUserProfiles();
        } catch (e) {
          userList = <User>[];
        }
      }

      MyDialog.popProgressBar(state.context);
      MyDialog.info(
          context: state.context,
          title: 'Login Success',
          message: 'Press <OK> to Navigate to User Home Page',
          action: () {
            Navigator.pop(state.context);
            Navigator.push(
                state.context,
                MaterialPageRoute(
                    builder: (context) => (state.user.isAdmin == null ||
                            state.user.isAdmin == false)
                        ? HomePage(state.user, storeCardList)
                        : AdminHomePage(state.user, userList, storeCardList)));
          });
    }
  }
}
