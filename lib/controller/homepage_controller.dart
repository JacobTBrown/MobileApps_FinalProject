import 'package:CMD/view/storepage.dart';
import 'package:flutter/material.dart';

import '../controller/myfirebase.dart';

import '../view/homepage.dart';
import '../view/cardviewpage.dart';
import '../view/sharedcardspage.dart';
import '../view/profilepage.dart';
import '../view/friendspage.dart';
import '../view/deckpage.dart';

import '../model/cardmodel.dart';

class HomePageController {
  HomePageState state;

  HomePageController(this.state);

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

  void signOut() {
      MyFirebase.signOut();
      Navigator.pop(state.context);
      Navigator.pop(state.context);
  }

  List<CardModel> getCards() {
    var list = List<CardModel>();
    for(int i = 0; i < state.user.cardsList.length; i++) {
      list.add(idCheck(i));
    }
    return list;
  }

  void sortCards(List<CardModel> list) {
    list.sort((card1, card2) => card1.name.compareTo(card2.name));
  }

  void findCards(String value) {
    state.searchCardList.clear();
    state.otherList.forEach((card) => {
      if (card.name.toLowerCase().startsWith(value.toLowerCase()))
        state.searchCardList.add(card),
    });
  }

  String validateUser(String value) {
    return '';
  }

  void saveUser(String value) {

  }

  void onTap(int index) async {
    CardModel temp = idCheck(index);
    if (state.deleteIndices == null) {
      CardModel b = await Navigator.push(state.context, MaterialPageRoute(  
        builder: (context) => CardViewPage(state.user, temp, false),
      ));

      if (b != null) {
        //update card stored in firebase
        temp = b;
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
    if (state.deleteIndices == null) {
      // begin delete
      state.stateChanged(() {
        state.deleteIndices = <int>[index];
      });
    }
  }

  void sharedWithMeMenu() async {
    List<CardModel> cards = await MyFirebase.getCardsSharedWithMe(state.user.email);
    print('# of cards: ' + cards.length.toString());
    for (var card in cards) {
      print(card.name);
    }
    // navigate to page of shared cards
    await Navigator.push(state.context, MaterialPageRoute(  
      builder: (context) => SharedCardsPage(state.user, cards),
    ));

    Navigator.pop(state.context);
  }

  void storePage() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => StorePage(state.user, state.storeCardList),
    ));
  }

  void profilePage() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ProfilePage(state.user),
    ));
  }

  void deckPage() {
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => DeckPage(state.user, state.storeCardList),
    ));
  }

  void friendsPage() async {
    if (state.user.friendsList.length != null) {
      print("Friend Length: ${state.user.friendsList.length}");
    }

    await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => FriendsPage(state.user),
    ));
  }
}