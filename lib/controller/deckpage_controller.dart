import 'package:CMD/model/deckmodel.dart';
import 'package:CMD/view/adddeckpage.dart';
import 'package:flutter/material.dart';

import '../controller/myfirebase.dart';

import '../view/deckpage.dart';
import '../view/viewdeckpage.dart';

import '../model/cardmodel.dart';

class DeckPageController {
  DeckPageState state;

  DeckPageController(this.state);

  String dropdownValue = 'Power';

  Color getColor(int index) {
    switch(idCheck(index).strategyType) {
      case "Power":
        return Color.fromRGBO(235, 62, 62, 1);
        break;
      case "Survival":
        return Color.fromRGBO(240, 122, 52, 1);
        break;
      case "Nobility":
        return Color.fromRGBO(187, 77, 227, 1);
        break;
      case "Diplomacy":
        return Color.fromRGBO(65, 146, 240, 1);
        break;
      case "Growth":
        return Color.fromRGBO(78, 168, 57, 1);
        break;
      case "Faith":
        return Color.fromRGBO(238, 182, 58, 1);
        break;
      default:
        return Colors.black;
        break;
    }
  }
  Color getWithColor(int index) {
    switch(idCheck(index).strategyType) {
      case "Power":
        return Color.fromRGBO(235, 62, 62, 1);
        break;
      case "Survival":
        return Color.fromRGBO(240, 122, 52, 1);
        break;
      case "Nobility":
        return Color.fromRGBO(187, 77, 227, 1);
        break;
      case "Diplomacy":
        return Color.fromRGBO(65, 146, 240, 1);
        break;
      case "Growth":
        return Color.fromRGBO(78, 168, 57, 1);
        break;
      case "Faith":
        return Color.fromRGBO(238, 182, 58, 1);
        break;
      default:
        return Colors.black;
        break;
    }
  }

  CardModel withIdCheck(String id) {
    return state.storeCardList.firstWhere((card) {
      if (card.documentId == id)
        return true;
      else return false;
    });
  }

  CardModel idCheck(int index) {
    return state.storeCardList.firstWhere((card) {
      if (card.documentId == state.user.cardsList[index])
        return true;
      else return false;
    });
  }

  void addDeck() async {
    DeckModel d = await Navigator.push(state.context, MaterialPageRoute(  
      builder: (context) => AddDeckPage(state.user, state.storeCardList),
    ));
    if (d != null) {
      //new deck stored in firebase
      String name;
      String cardId;
      DeckEntry entry;
      for (int i = 0; i < d.cardsList.length; i++) {
        name = d.deckName + i.toString();
        cardId = d.cardsList[i];
        entry = new DeckEntry(name, cardId);
        state.user.deckList.addAll({entry.k: entry.v});
      }
      var list = [].toList(growable: true);
      list.addAll(state.user.deckNameList);
      list.add(d.deckName);
      state.user.deckNameList = list;
      state.deckCount = state.user.deckNameList.length;
      MyFirebase.updateInfo(state.user.uid, state.user);
      state.stateChanged(() {});
      print('MAP ADDITION COMPLETE');
    } else {
      //error occurred in storing in firebase
      print('MAP NOT COMPLETED');
    }
  }

  void onTap(int index) async {
    if (state.deleteIndices == null) {
      await Navigator.push(state.context, MaterialPageRoute(  
        builder: (context) => ViewDeckPage(state.user, index, state.storeCardList),
      ));
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
    if (state.deleteIndices == null) {
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
        String name = state.user.deckNameList[index];
        int cardCount = 0;
        for (var key in state.user.deckList.keys) {
          if (key == name+cardCount.toString()) {
            cardCount++;
          }    
        }

        for(int i = 0; i < cardCount; i++) {
          state.user.deckList.remove(name+i.toString());
        }
        state.user.deckNameList.removeAt(index);
      } catch (e) {
        print('DECK DELETE ERROR: ' + e.toString());
      }
    }
    state.deckCount = state.user.deckNameList.length;

    MyFirebase.updateInfo(state.user.uid, state.user);

    state.stateChanged(() {
      state.deleteIndices = null;
    }); 
  }
}