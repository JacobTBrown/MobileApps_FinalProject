class User {
  String email;
  String password;
  String displayName;
  String profileImage;
  String createdOn;
  String timePlayed;
  String ranking;
  String theme;
  String country;
  String state;
  int numFriends;
  int numCards;
  int numDecks;
  double points;
  String uid;
  bool isAdmin;

  List<dynamic> friendsList = <dynamic>[].toList(growable: true);
  List<dynamic> cardsList = <dynamic>[].toList(growable: true);
  List<dynamic> deckNameList = <dynamic>[].toList(growable: true);
  Map<dynamic, dynamic> deckList = new Map<dynamic, dynamic>();

  User({
    this.email,
    this.password,
    this.displayName,
    this.profileImage,
    this.createdOn,
    this.timePlayed,
    this.ranking,
    this.theme,
    this.country,
    this.state,
    this.numFriends,
    this.numCards,
    this.numDecks,
    this.points,
    this.uid,
    this.isAdmin,
    this.friendsList,
    this.cardsList,
    this.deckNameList,
    this.deckList,
  });

  User.clone(User b) {
    this.email = b.email;
    this.password = b.password;
    this.displayName = b.displayName;
    this.profileImage = b.profileImage;
    this.createdOn = b.createdOn;
    this.timePlayed = b.timePlayed;
    this.ranking = b.ranking;
    this.theme = b.theme;
    this.country = b.country;
    this.state = b.state;
    this.numFriends = b.numFriends;
    this.numCards = b.numCards;
    this.numDecks = b.numDecks;
    this.points = b.points;
    this.uid = b.uid;
    this.isAdmin = b.isAdmin;
    this.friendsList = <dynamic>[]..addAll(b.friendsList);
    this.cardsList = <dynamic>[]..addAll(b.cardsList);
    this.deckNameList = <dynamic>[]..addAll(b.deckNameList);
    this.deckList = Map<dynamic, dynamic>()..addAll(b.deckList);
  }

  Map<String, dynamic> serialize() {
    return <String, dynamic>{ 
      EMAIL: email,
      PASSWORD: password,
      DISPLAYNAME: displayName,
      PROFILEIMAGE: profileImage,
      CREATEDON: createdOn,
      TIMEPLAYED: timePlayed,
      RANKING: ranking,
      THEME: theme,
      COUNTRY: country,
      STATE: state,
      NUMFRIENDS: numFriends,
      NUMCARDS: numCards,
      NUMDECKS: numDecks,
      POINTS: points,
      UID: uid,
      ISADMIN: isAdmin,
      FRIENDSLIST: friendsList,
      CARDSLIST: cardsList,
      DECKNAMELIST: deckNameList,
      DECKLIST: deckList,
    };
  }

  static User deserialize(Map<String, dynamic> document) {
    return User(
      email: document[EMAIL],
      password: document[PASSWORD],
      displayName: document[DISPLAYNAME],
      profileImage: document[PROFILEIMAGE],
      createdOn: document[CREATEDON],
      timePlayed: document[TIMEPLAYED],
      ranking: document[RANKING],
      theme: document[THEME],
      country: document[COUNTRY],
      state: document[STATE],
      numFriends: document[NUMFRIENDS],
      numCards: document[NUMCARDS],
      numDecks: document[NUMDECKS],
      points: document[POINTS],
      uid: document[UID],
      isAdmin: document[ISADMIN],
      friendsList: document[FRIENDSLIST],
      cardsList: document[CARDSLIST],
      deckNameList: document[DECKNAMELIST],
      deckList: document[DECKLIST],
    );
  }

  static const PROFILE_COLLECTION = 'userprofile';
  static const EMAIL = 'email';
  static const PASSWORD = 'password';
  static const DISPLAYNAME = 'displayName';
  static const PROFILEIMAGE = 'profileImage';
  static const CREATEDON = 'createdOn';
  static const TIMEPLAYED = 'timePlayed';
  static const RANKING = 'ranking';
  static const THEME = 'theme';
  static const COUNTRY = 'country';
  static const STATE = 'state';
  static const NUMFRIENDS = 'numFriends';
  static const NUMCARDS = 'numCards';
  static const NUMDECKS = 'numDecks';
  static const POINTS = 'points';
  static const UID = 'uid';
  static const ISADMIN = 'isAdmin';
  static const FRIENDSLIST = 'friendsList';
  static const CARDSLIST = 'cardsList';
  static const DECKNAMELIST = 'deckNameList';
  static const DECKLIST = 'deckList';
}