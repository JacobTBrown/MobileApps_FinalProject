import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';

import '../controller/myfirebase.dart';
import '../model/descriptors.dart';
import '../view/cardaddpage.dart';
import '../view/mydialog.dart';

class CardAddPageController {

  CardAddPageState state;

  List<dynamic> tags;

  CardAddPageController(this.state) {
    tags = List<dynamic>();
    tags.add(Descriptors.getMythGreek());
    tags.add(Descriptors.getMythNorse());
    tags.add(Descriptors.getMythEgyptian());
  }

  String dropdownStratValue = 'Power';
  String dropdownCombatValue = 'Physical';
  String dropdownMythValue = 'Greek';
  String tempImageURL = '';
  int descriptionCharCount = 0;


  Image getBorder() {
    return Image(image: AssetImage('assets/faith_border.png'),);
  }

  void onTagPressed(Item item) {
    if (item.active)
      item.active = false;
    else
      item.active = true;
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
    dropdownStratValue = value;
    state.cardCopy.strategyType = dropdownStratValue;
  }

  void saveCombatType(String value) {
    dropdownCombatValue = value;
    state.cardCopy.combatType = dropdownCombatValue;
  }

  void saveMyth(String value) {
    dropdownMythValue = value;
    state.cardCopy.myth = dropdownMythValue;
  }

  void saveDescription(String value) {
    state.cardCopy.description = value;
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
    state.cardCopy.identityTags..addAll(tags);
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
}