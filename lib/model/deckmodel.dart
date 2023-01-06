import 'package:flutter_tags/tag.dart';

class DeckEntry {
  dynamic k;
  dynamic v;
  DeckEntry(this.k, this.v);

  dynamic getValue(dynamic kv) {
    if (kv == k)
      return v;
  }
}

class DeckModel {
  String deckName;
  String createdBy;
  DateTime lastUpdatedAt;
  
  List<ItemTags> identityTags = [];
  List<dynamic> cardsList = <dynamic>[];

  DeckModel({
    this.deckName,
    this.createdBy,
    this.lastUpdatedAt,
    this.identityTags,
    this.cardsList,
  });

  DeckModel.clone(DeckModel b) {
    this.deckName = b.deckName;
    this.createdBy = b.createdBy;
    this.lastUpdatedAt = b.lastUpdatedAt;
    this.identityTags = []..addAll(b.identityTags);
    this.cardsList = <dynamic>[]..addAll(b.cardsList);
  }

  static const DECK_CARDLIMIT = 40;
}