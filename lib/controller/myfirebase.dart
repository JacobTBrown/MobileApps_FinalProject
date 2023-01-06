import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';
import '../model/cardmodel.dart';

class MyFirebase {
  static Future<String> createAccount({String email, String password}) async {
    AuthResult auth =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    print('account created');

    return auth.user.uid;
  }

  static void createProfile(User user) async {
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .setData(user.serialize());
  }

  static Future<String> login({String email, String password}) async {
    AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user.uid;
  }

  static void deleteUser(User user) async{
    AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );

    deleteProfile(user.uid);
    auth.user.delete();
  }

  static Future<User> readProfile(String uid) async {
    DocumentSnapshot doc = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(uid)
        .get();
    return User.deserialize(doc.data);
  }

  static void deleteProfile(String uid) async {
    await Firestore.instance
      .collection(User.PROFILE_COLLECTION)
      .document(uid)
      .delete();
  }

  static Future<List<User>> getUserProfiles() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .getDocuments();
    var userList = <User>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return userList;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      userList.add(User.deserialize(doc.data));
    }
    return userList;
  }

  static void updateInfo(String uid, User user) async {
    Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(uid)
        .updateData(user.serialize());
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  static Future<String> addCard(CardModel card, String uid, User user) async {
    DocumentReference rf = await Firestore.instance
        .collection(CardModel.CARDSCOLLECTION)
        .add(card.serialize());

    return rf.documentID;
  }

  static Future<List<CardModel>> getCards(String email) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(CardModel.CARDSCOLLECTION)
        .where(CardModel.CREATEDBY, isEqualTo: email)
        .getDocuments();
    var cardlist = <CardModel>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return cardlist;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      cardlist.add(CardModel.deserialize(doc.data, doc.documentID));
    }
    return cardlist;
  }

  static Future<List<CardModel>> getStoreCards() async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(CardModel.CARDSCOLLECTION)
        .getDocuments();
    var cardlist = <CardModel>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return cardlist;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      cardlist.add(CardModel.deserialize(doc.data, doc.documentID));
    }
    return cardlist;
  }

  static Future<void> updateCard(CardModel card) async {
    await Firestore.instance
        .collection(CardModel.CARDSCOLLECTION)
        .document(card.documentId)
        .setData(card.serialize());
  }

  static Future<void> deleteCard(CardModel card, String uid, User user) async {
    await Firestore.instance
        .collection(CardModel.CARDSCOLLECTION)
        .document(card.documentId)
        .delete();
  }

  static Future<List<CardModel>> getCardsSharedWithMe(String email) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection(CardModel.CARDSCOLLECTION)
          .where(CardModel.SHAREDWITH, arrayContains: email)
          .orderBy(CardModel.CREATEDBY)
          .orderBy(CardModel.LASTUPDATEDAT)
          .getDocuments();
      var cards = <CardModel>[];
      if (querySnapshot == null || querySnapshot.documents.length == 0) {
        return cards;
      }
      for (DocumentSnapshot doc in querySnapshot.documents) {
        cards.add(CardModel.deserialize(doc.data, doc.documentID));
      }
      return cards;
    } catch (e) {
      throw e;
    }
  }

  static Future<User> getUserByDisplayName(String displayName) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection(User.PROFILE_COLLECTION)
          .where(User.DISPLAYNAME, isEqualTo: displayName)
          .getDocuments();
      if (querySnapshot == null || querySnapshot.documents.length == 0) {
        print('found nothing');
        return null;
      }
      return User.deserialize(querySnapshot.documents.first.data);
    } catch (e) {
      throw e;
    }
  }

  static Future<CardModel> getACard(CardModel card) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection(CardModel.CARDSCOLLECTION)
          .where(CardModel.LASTUPDATEDAT, isEqualTo: card.lastUpdatedAt)
          .getDocuments();
      if (querySnapshot == null || querySnapshot.documents.length == 0) {
        print('found nothing');
        return null;
      }
      return CardModel.deserialize(querySnapshot.documents.first.data,
          querySnapshot.documents.first.documentID);
    } catch (e) {
      throw e;
    }
  }
}
