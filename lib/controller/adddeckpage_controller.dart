import 'package:CMD/model/cardmodel.dart';
import 'package:CMD/model/deckmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';

import '../controller/myfirebase.dart';
import '../view/adddeckpage.dart';
import '../view/mydialog.dart';

class AddDeckPageController {

  AddDeckPageState state;

  AddDeckPageController(this.state);

  String dropdownStratValue = 'Power';
  String dropdownCombatValue = 'Physical';
  int descriptionCharCount = 0;

  String deckName;

  DeckModel deckModel;
  List<dynamic> cardList;

  List<ItemTags> tags = [];

  void addTags() {
    tags.add(ItemTags(title: 'Monster'));
    tags.add(ItemTags(title: 'Humanoid'));
    tags.add(ItemTags(title: 'Champion'));
  }

  CardModel idDeckCheck(int index) {
    return state.storeCardList.firstWhere((card) {
      if (card.documentId == this.cardList[index])
        return true;
      else return false;
    });
  }

  String getDeckImageUrl(int index) {
    return idDeckCheck(index).imageUrl;
  }

  String getDeckColor(int index) {
    return idDeckCheck(index).strategyType;
  }

  CardModel idCheck(int index) {
    return state.storeCardList.firstWhere((card) {
      if (card.documentId == state.user.cardsList[index])
        return true;
      else return false;
    });
  }

  String getCardColor(int index) {
    return idCheck(index).strategyType;
  }

  String getCardImageUrl(int index) {
    return idCheck(index).imageUrl;
  }

  String getCardName(int index) {
    return idCheck(index).name;
  }
  
  void setDeckName(String name) {
    deckName = name;
  }

  void onTagPressed(ItemTags tag) {
    tag.active = true;
  }

  void saveName(String value) {
    setDeckName(value);
  }

  void onTap(int index) {
    this.cardList.add(state.user.cardsList[index]);
    print('Card added: ' + this.cardList.length.toString());
  }

  String validateName(String value) { 
    if (value == null || value.length < 4) {
      return 'Enter name';
    }
    return null;
  }

  void save() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }
    state.formKey.currentState.save();

    deckModel = DeckModel(
      deckName: deckName,
      cardsList: cardList,
      createdBy: state.user.email,
    );

    try {
      MyFirebase.updateInfo(state.user.uid, state.user);
      Navigator.pop(state.context, deckModel);
    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Firestore Save Error',
        message: 'Firestore is unavailable now. Try again',
        action: () {
          Navigator.pop(state.context, null);
          Navigator.pop(state.context, null); 
        },
      );
    }
  }
}