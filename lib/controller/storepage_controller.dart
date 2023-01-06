import 'package:flutter/material.dart';

import '../controller/myfirebase.dart';

import '../view/storepage.dart';
import '../view/cardaddpage.dart';
import '../view/cardviewpage.dart';

import '../model/cardmodel.dart';

class StorePageController {
  StorePageState state;

  List<CardModel> searchCardList;

  StorePageController(this.state) {
    searchCardList = List<CardModel>();
    searchCardList.addAll(state.storeCardsList);
  }

  void addButton() async {
    CardModel b = await Navigator.push(state.context, MaterialPageRoute(  
      builder: (context) => CardAddPage(state.user, null),
    ));
    if (b != null) {
      //new card stored in firebase
      searchCardList.add(b);
      state.storeCardsList.add(b);
    } else {
      //error occurred in storing in firebase
    }
    state.stateChanged(() {});
  }

  void onTap(int index) async {
    if (state.deleteIndices == null) {
      CardModel b = await Navigator.push(state.context, MaterialPageRoute(  
        builder: (context) => CardViewPage(state.user, searchCardList[index], true),
      ));

      if (b != null) {
        //update card stored in firebase
        searchCardList[index] = b;
      }
    } else {
      // add to delete list
      if (state.deleteIndices.contains(index)) {
        // tapp again - deselect
        state.deleteIndices.remove(index);
        if (state.deleteIndices.length == 0) {
          // all deselected 
          state.deleteIndices = null;
        }
      } else {
        state.deleteIndices.add(index);
      }
      state.stateChanged((){ });
    }
    
  }

  void longPress(int index) {
    if (state.deleteIndices == null && (state.user.isAdmin != null && state.user.isAdmin != false)) {
      // begin delete
      state.stateChanged(() {
        state.deleteIndices = <int>[index];
      });
    }
  }

  void deleteButton() async {
    // sort descending order
    state.deleteIndices.sort((n1, n2) {
      if (n1 < n2) 
        return 1;
      else if (n1 == n2)
        return 0;
      else
        return -1;
    });

    // deleteindices: [a, b]
    for (var index in state.deleteIndices) {
      try {
        await MyFirebase.deleteCard(state.storeCardsList[index], state.user.uid, state.user);
        int i = state.storeCardsList.indexOf(searchCardList.removeAt(index));
        state.storeCardsList.removeAt(i);
      } catch (e) {
        print('CARD DELETE ERROR: ' + e.toString());
      }
    }
    state.stateChanged(() {
      state.deleteIndices = null;
    }); 
  }

  void sortCards(List<CardModel> list) {
    list.sort((card1, card2) => card1.name.compareTo(card2.name));
  }

  void findCards(String value) {
    searchCardList.clear();
    state.storeCardsList.forEach((card) => {
      if (card.name.toLowerCase().startsWith(value.toLowerCase()))
        searchCardList.add(card),
    });
  }

  String validateUser(String value) {
    return '';
  }

  void saveUser(String value) {

  }
}