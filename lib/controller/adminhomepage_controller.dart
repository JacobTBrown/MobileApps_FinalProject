import 'package:CMD/view/adminaccountspage.dart';
import 'package:CMD/view/adminhomepage.dart';
import 'package:CMD/view/storepage.dart';
import 'package:CMD/view/suggestionpage.dart';
import 'package:flutter/material.dart';

import '../controller/myfirebase.dart';

class AdminHomePageController {
  AdminHomePageState state;

  AdminHomePageController(this.state);

  void signOut() {
      MyFirebase.signOut();
      Navigator.pop(state.context);
      Navigator.pop(state.context);
  }

void registeredAccountsPage() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => AdminAccountsPage(state.user, state.userList, state.storeCardList),
    ));
  }

  void getCardStore() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => StorePage(state.user, state.storeCardList),
    ));
  }

  void suggestionsPage() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => SuggestionPage(state.user),
    ));
  }
}