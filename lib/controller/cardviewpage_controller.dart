import 'package:CMD/model/cardmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';

import '../controller/myfirebase.dart';
import '../view/cardviewpage.dart';
import '../view/mydialog.dart';

class CardViewPageController {
  CardViewPageState state;

  CardViewPageController(this.state) {
    if(state.cardCopy.identityTags == null)
      tags = List<dynamic>();
    else tags.addAll(state.cardCopy.identityTags);
  }

  String dropdownStratValue = 'Power';
  String dropdownCombatValue = 'Physical';
  int descriptionCharCount = 0;

  List<dynamic> tags = [];
  var list = [];

  void onTagPressed(Item tag) {
    tag.active = true;
  }

  void saveDescription(String value) {
    state.cardCopy.description = value;
  }
  
  String validateImageUrl(String value) { 
    if (value == null || value.length < 5) {
      return 'Enter image url';
    }
    return null;
  }

  void saveImageUrl(String value) {
    state.cardCopy.imageUrl = value;
  }

  String validateName(String value) { 
    if (value == null || value.length < 4) {
      return 'Enter card title';
    }
    return null;
  }

  void saveName(String value) {
    state.cardCopy.name = value;
  }

  String validatePrice(String value) { 
    return null;
  }

  void savePrice(String value) {
    state.cardCopy.price = double.parse(value);
  }

  String validateSharedWith(String value) { 
    if (value == null || value.trim().isEmpty) {
      return null; // no sharing
    }
    for (var email in value.split(',')) {
      if (!(email.contains('.') && email.contains('@'))) {
        return 'Enter comma(,) separated email list';
      }
      if (email.indexOf('@') != email.lastIndexOf('@')) {
        return 'Enter comma(,) separated email list';
      }
    }

    return null;
  }

  void saveSharedWith(String value) {
    if (value == null || value.trim().isEmpty) {
      return;
    }
    state.cardCopy.sharedWith = [];
    List<String> emaillist = value.split(',');
    for (var email in emaillist) {
      state.cardCopy.sharedWith.add(email.trim());
    }
  }

  void saveStrategyType(String value) {
    state.cardCopy.strategyType = value;
  }

  void saveCombatType(String value) {
    state.cardCopy.combatType = value;
  }

  Widget returnWidget() {
    if (state.user.isAdmin == null || state.user.isAdmin == false) 
      return Text('Buy \$${state.cardCopy.price}');
    else
      return Text('Save');
  }

  void save() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }
    state.formKey.currentState.save();

    if (state.cardCopy.strategyType == null || state.cardCopy.strategyType.isEmpty)
      saveStrategyType(dropdownStratValue);
    if (state.cardCopy.combatType == null || state.cardCopy.combatType.isEmpty)
      saveCombatType(dropdownCombatValue);
    if (state.cardCopy.description == null || state.cardCopy.description.isEmpty)
      saveDescription('');
    state.cardCopy.createdBy = state.user.email;
    state.cardCopy.lastUpdatedAt = DateTime.now();

    try {
      if (state.card == null) { // add
        state.cardCopy.documentId = await MyFirebase.addCard(state.cardCopy, state.user.uid, state.user);
      } else 
        await MyFirebase.updateCard(state.cardCopy);
      Navigator.pop(state.context, state.cardCopy);
    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Firestore Save Error',
        message: 'Firestore is unavailable now. Try again',
        action: () {
          Navigator.pop(state.context);
          Navigator.pop(state.context, null); 
        },
      );
    }
  }

  void buy() async {
    if (state.user.points < state.cardCopy.price) {
      MyDialog.info(
        context: state.context,
        title: 'Buy Card Error',
        message: "You don't have enough points.",
        action: () => Navigator.pop(state.context),
      );
      return;
    } else {
      state.user.points -= state.cardCopy.price;
    }

    var temp = await MyFirebase.getACard(state.cardCopy);

    if (temp == null) {
      MyDialog.info(
        context: state.context,
        title: 'Get Card Error',
        message: 'Could not find the card.',
        action: () => Navigator.pop(state.context),
      );
      return;
    }

    CardModel cardToAdd = CardModel.clone(temp);
    if (state.user.cardsList.contains(cardToAdd.documentId)) {
      MyDialog.info(
        context: state.context,
        title: 'Add Card Error',
        message: 'You already own this card!',
        action: () => Navigator.pop(state.context),
      );
      return;
    }

    if (cardToAdd != null) {
      MyDialog.info(
        context: state.context,
        title: 'Success!',
        message: 'You successfully purchase this card!',
        action: () => {
          Navigator.pop(state.context),
          Navigator.pop(state.context),
        },
      );
      print(state.user.cardsList.length);
      list.addAll(state.user.cardsList);
      list.add(cardToAdd.documentId);

      state.stateChanged(() {
        state.user.cardsList = list;
        state.user.numCards = state.user.cardsList.length;
        MyFirebase.updateInfo(state.user.uid, state.user);
      });
    }
  }
}
