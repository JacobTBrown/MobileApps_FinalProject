import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../model/cardmodel.dart';
import '../model/theme.dart';
import '../controller/homepage_controller.dart';

class HomePage extends StatefulWidget {
  final User user;
  final List<CardModel> storeCardList;

  HomePage(this.user, this.storeCardList);

  @override
  State<StatefulWidget> createState() {
    return HomePageState(user, storeCardList);
  }
}

class HomePageState extends State<HomePage> {
  User user;
  CardModel temp;
  List<CardModel> storeCardList;
  List<CardModel> otherList;
  List<CardModel> searchCardList;
  List<int> deleteIndices;

  HomePageController controller;
  BuildContext context;

  var textEdit = new TextEditingController();

  HomePageState(this.user, this.storeCardList) {
    controller = HomePageController(this);

    searchCardList = new List<CardModel>();
    otherList = new List<CardModel>();
    otherList.addAll(controller.getCards());
    searchCardList.addAll(otherList);
    controller.sortCards(searchCardList);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('User Home'),
            actions: deleteIndices == null
                ? null
                : <Widget>[
                    FlatButton.icon(
                      label: Text('Create'),
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    )
                  ],
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(user.displayName),
                  accountEmail: Text(user.email),
                  currentAccountPicture: Container(
                    color: Colors.black45,
                    margin: EdgeInsets.all(10),
                    child: CachedNetworkImage(
                      imageUrl: "${user.profileImage}",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),
                    ),
                  ),
                ),
                Container(
                  color: Themes.mainLightAccent,
                  margin: EdgeInsets.only(bottom: 3),
                  child: ListTile(
                    leading: Icon(Icons.store),
                    title: Text('Store'),
                    onTap: controller.storePage,
                  ),
                ),
                Container(
                  color: Themes.mainLightAccent,
                  margin: EdgeInsets.only(bottom: 3),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('My Profile'),
                    onTap: controller.profilePage,
                  ),
                ),
                Container(
                  color: Themes.mainLightAccent,
                  margin: EdgeInsets.only(bottom: 3),
                  child: ListTile(
                    leading: Icon(Icons.people),
                    title: Text('Friends'),
                    onTap: controller.friendsPage,
                  ),
                ),
                Container(
                  color: Themes.mainLightAccent,
                  margin: EdgeInsets.only(bottom: 3),
                  child: ListTile(
                    leading: Icon(Icons.collections),
                    title: Text('Decks'),
                    onTap: controller.deckPage,
                  ),
                ),
                Container(
                  color: Themes.mainLightAccent,
                  margin: EdgeInsets.only(bottom: 3),
                  child: ListTile(
                    leading: Icon(Icons.collections),
                    title: Text('Card Collection'),
                    subtitle: Text('subtitle'),
                    onTap: () {},
                  ),
                ),
                Container(
                  color: Themes.mainLightAccent,
                  margin: EdgeInsets.only(bottom: 3),
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Recommended To Me'),
                    onTap: controller.sharedWithMeMenu,
                  ),
                ),
                Container(
                  color: Themes.mainLightAccent,
                  margin: EdgeInsets.only(bottom: 3),
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Sign Out'),
                    onTap: controller.signOut,
                  ),
                )
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          color: Colors.black45,
                          margin: EdgeInsets.all(10),
                          child: CachedNetworkImage(
                            alignment: Alignment.center,
                            height: 150,
                            width: 150,
                            imageUrl: "${user.profileImage}",
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error_outline),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                'Username: ${user.displayName}',
                                style: TextStyle(fontSize: 12),
                              )),
                              Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Points: \$${user.points}',
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    'Created: ${user.createdOn}',
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Time Played: ${user.timePlayed}',
                                    style: TextStyle(fontSize: 12),
                                  )),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Rank',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          top: 25,
                                          left: 55,
                                          right: 25,
                                          bottom: 25),
                                      child: Text(
                                        '${user.ranking}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Friends: ${user.numFriends}',
                                style: TextStyle(fontSize: 12),
                              )),
                          Container(
                              child: Text('Cards: ${user.numCards}',
                                  style: TextStyle(fontSize: 12))),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                'Decks: ${user.numDecks}',
                                style: TextStyle(fontSize: 12),
                              ))
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                                          child: TextFormField(
                        controller: textEdit,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: "Enter a card name",
                          labelText: 'Search Card Collection',
                        ),
                        validator: controller.validateUser,
                        onSaved: controller.saveUser,
                        onChanged: (value) => {
                          stateChanged(() {
                            controller.findCards(value);
                            if (value.isEmpty)
                              controller.sortCards(searchCardList);
                          })
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: .75, crossAxisCount: 5),
                  itemCount: searchCardList.length,
                  itemBuilder: (context, index) => Container(
                    child: GestureDetector(
                      onTap: () {
                        controller.onTap(index);
                      },
                      onLongPress: () {
                        controller.longPress(index);
                      },
                      child: Card(
                          color: Themes.getCardColoring(
                              searchCardList[index].strategyType),
                          elevation: 10,
                          shape: BeveledRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black,
                                  style: BorderStyle.solid)),
                          borderOnForeground: true,
                          child: Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          searchCardList[index].imageUrl,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error_outline),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: Text(
                                        '${searchCardList[index].name}',
                                        style: TextStyle(
                                            color: Themes.mainDarkShade),
                                      ),
                                    ),
                                  ),
                                ],
                              ))),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
