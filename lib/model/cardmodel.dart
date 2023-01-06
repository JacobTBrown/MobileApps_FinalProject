class CardModel {
  String documentId;  // firestore doc id
  String imageUrl;
  String name;
  String description;
  double price;
  int atk;
  int def;
  int turnsLeft;
  String strategyType;
  String combatType;
  String myth;
  String createdBy;
  DateTime lastUpdatedAt;
  
  List<dynamic> identityTags = <dynamic>[];
  List<dynamic> sharedWith = <dynamic>[];

  CardModel({
    this.documentId,
    this.imageUrl,
    this.name,
    this.description,
    this.price,
    this.atk,
    this.def,
    this.turnsLeft,
    this.strategyType,
    this.combatType,
    this.myth,
    this.createdBy,
    this.lastUpdatedAt,
    this.identityTags,
    this.sharedWith,
  });

  CardModel.empty({
    this.documentId = '',
    this.imageUrl = '',
    this.name = '',
    this.description = '',
    this.price = 0.0,
    this.atk = 0,
    this.def = 0,
    this.turnsLeft = 0,
    this.strategyType = '',
    this.combatType = '',
    this.myth = '',
    this.createdBy = '',
  });

  CardModel.clone(CardModel b) {
    this.documentId = b.documentId;
    this.imageUrl = b.imageUrl;
    this.name = b.name;
    this.description = b.description;
    this.price = b.price;
    this.atk = b.atk;
    this.def = b.def;
    this.turnsLeft = b.turnsLeft;
    this.strategyType = b.strategyType;
    this.combatType = b.combatType;
    this.myth = b.myth;
    this.createdBy = b.createdBy;
    this.lastUpdatedAt = b.lastUpdatedAt;
    this.identityTags = []..addAll(b.identityTags);
    this.sharedWith = <dynamic>[]..addAll(b.sharedWith);
  }

  Map<String, dynamic> serialize() {
    return <String, dynamic>{
      DOCUMENTID: documentId,
      IMAGEURL: imageUrl,
      NAME: name,
      DESCRIPTION: description,
      PRICE: price,
      ATK: atk,
      DEF: def,
      TURNSLEFT: turnsLeft,
      STRATEGYTYPE: strategyType,
      COMBATTYPE: combatType,
      MYTH: myth,
      CREATEDBY: createdBy,
      LASTUPDATEDAT: lastUpdatedAt,
      IDENTITYTAGS: identityTags,
      SHAREDWITH: sharedWith,
    };
  }

  static CardModel deserialize(Map<String, dynamic> data, String docId) {
    var card = CardModel(
      documentId: data[CardModel.DOCUMENTID],
      imageUrl: data[CardModel.IMAGEURL],
      name: data[CardModel.NAME],
      description: data[CardModel.DESCRIPTION],
      price: data[CardModel.PRICE],
      atk: data[CardModel.ATK],
      def: data[CardModel.DEF],
      turnsLeft: data[CardModel.TURNSLEFT],
      strategyType: data[CardModel.STRATEGYTYPE],
      combatType: data[CardModel.COMBATTYPE],
      myth: data[CardModel.MYTH],
      createdBy: data[CardModel.CREATEDBY],
      identityTags: data[CardModel.IDENTITYTAGS],
      sharedWith: data[CardModel.SHAREDWITH],
    );
    if (data[CardModel.LASTUPDATEDAT] != null) {
      card.lastUpdatedAt = DateTime.fromMillisecondsSinceEpoch(data[CardModel.LASTUPDATEDAT].millisecondsSinceEpoch);
    }
    card.documentId = docId;
    return card;
  }

  static const CARDSCOLLECTION = 'cards';
  static const DOCUMENTID = 'documentId';
  static const IMAGEURL = 'imageUrl';
  static const NAME = 'name';
  static const DESCRIPTION = 'description';
  static const PRICE = 'price';
  static const ATK = 'atk';
  static const DEF = 'def';
  static const TURNSLEFT = 'turnsLeft';
  static const STRATEGYTYPE = 'strategyType';
  static const COMBATTYPE = 'combatType';
  static const MYTH = 'myth';
  static const CREATEDBY = 'createdBy';
  static const LASTUPDATEDAT = 'lastUpdatedAt';
  static const IDENTITYTAGS = 'identityTags';
  static const SHAREDWITH = 'sharedWith';
}