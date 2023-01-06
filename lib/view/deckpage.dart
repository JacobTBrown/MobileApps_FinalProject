import 'package:CMD/model/deckmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../controller/deckpage_controller.dart';

class DeckPage extends StatefulWidget {
  final User user;
  final List<dynamic> storeCardList;

  DeckPage(this.user, this.storeCardList);

  @override
  State<StatefulWidget> createState() {
    return DeckPageState(user, storeCardList);
  }
}

class DeckPageState extends State<DeckPage> {
  User user;
  List<int> deleteIndices;
  List<dynamic> storeCardList;

  DeckPageController controller;
  BuildContext context;

  var list = [];
  var deckCount;

  DeckPageState(this.user, this.storeCardList) {
    controller = DeckPageController(this);

    user.deckList.forEach((k, v) => list.add(DeckEntry(k, v)));
    deckCount = (user.deckNameList != null || user.deckNameList.isEmpty) ? user.deckNameList.length : 0;
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(
          title: Text('Decks'),
          actions: deleteIndices == null
              ? null
              : <Widget>[
                  FlatButton.icon(
                    label: Text('Delete'),
                    icon: Icon(Icons.delete),
                    onPressed: controller.deleteButton,
                  )
                ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: controller.addDeck,
        ),
        body: Container(
          color: Color.fromRGBO(55, 55, 55, 1),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white24,
                      height: 100,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Deck List',
                        style: TextStyle(
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      thickness: 4,
                    )
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .75, crossAxisCount: 5),
                itemCount: deckCount,
                itemBuilder: (context, index) => Container(
                  child: GestureDetector(
                    onTap: () {
                      controller.onTap(index);
                    },
                    onLongPress: () {
                      controller.longPress(index);
                    },
                    child: Card(
                        color: controller.getWithColor(index),
                        elevation: 10,
                        shape: BeveledRectangleBorder(
                            side: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid)),
                        borderOnForeground: true,
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: CachedNetworkImage(
                                imageUrl: controller.withIdCheck(user.deckList[(user.deckNameList[index]+'0').toString()]).imageUrl,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error_outline),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${user.deckNameList[index]}',
                              ),
                            ),
                          ],
                        ))),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
