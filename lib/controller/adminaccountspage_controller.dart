import 'package:CMD/controller/myfirebase.dart' as prefix0;
import 'package:CMD/model/user.dart';
import 'package:CMD/view/adminaccountspage.dart';
import 'package:CMD/view/profilepage.dart';
import 'package:CMD/view/registerpage.dart';
import 'package:CMD/view/storepage.dart';
import 'package:flutter/material.dart';

import '../controller/myfirebase.dart';

class AdminAccountsPageController {
  AdminAccountsPageState state;

  AdminAccountsPageController(this.state);

  void signOut() {
      MyFirebase.signOut();
      Navigator.pop(state.context);
      Navigator.pop(state.context);
  }

  void addUser() async {
    User newUser = await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => RegisterPage(),
    ));
    state.userList.add(newUser);
    state.stateChanged((){});
  }

  void editUser(User user) {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ProfilePage(user),
    ));
    state.stateChanged((){});
  }

  void deleteUser(User user) {
    state.userList.remove(user);
    MyFirebase.deleteUser(user);
    
    state.stateChanged((){});
  }

  void getCardStore() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => StorePage(state.user, state.storeCardList),
    ));
  }
}