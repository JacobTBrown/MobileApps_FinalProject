import 'package:flutter/material.dart';

import '../view/friendspage.dart';
import './myfirebase.dart';
import '../view/mydialog.dart';
import '../view/comparewithfriendpage.dart';

import '../model/user.dart';

class FriendsPageController {

  FriendsPageState state;

  FriendsPageController(this.state);

  var list = [];

  void addFriend() async {
    if (state.textEdit.text == state.user.displayName) {
      MyDialog.info( 
        context: state.context,
        title: 'Add User Error',
        message: "You can't add yourself.",
        action: () => Navigator.pop(state.context),
      );
      return;
    }
    
    var temp = await MyFirebase.getUserByDisplayName(state.textEdit.text);

    if (temp == null) {
      MyDialog.info( 
        context: state.context,
        title: 'Add User Error',
        message: 'Could not find User',
        action: () => Navigator.pop(state.context),
      );
      return;
    }
    
    User friendToAdd = User.clone(temp);
    if (state.user.friendsList.contains(friendToAdd.displayName)) {
      MyDialog.info( 
        context: state.context,
        title: 'Add User Error',
        message: 'This user is already your friend!',
        action: () => Navigator.pop(state.context),
      );
      return;
    }

    if (friendToAdd != null) {
      print('SUCCESS');
      print(state.user.friendsList.length);
      
      state.stateChanged(() {
        list.add(friendToAdd.displayName);
        state.user.friendsList = list;
        state.user.numFriends = state.user.friendsList.length;
        MyFirebase.updateInfo(state.user.uid, state.user);
      });
    }
  }

  void compareWithFriend(String friendName) async {
    var temp = await MyFirebase.getUserByDisplayName(friendName);

    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => CompareWithFriendPage(state.user, temp),
    ));
  }

  void deleteFriend(String friendName) async {
    state.user.friendsList.remove(friendName);
    state.user.numFriends = state.user.friendsList.length;
    state.stateChanged(() {
      MyFirebase.updateInfo(state.user.uid, state.user);
    });
  }

  String validateUser(String value) {
    return '';
  }

  void saveUser(String value) {

  }
}