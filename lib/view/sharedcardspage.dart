import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controller/sharedcardspage_controller.dart';
import '../model/cardmodel.dart';
import '../model/user.dart';

class SharedCardsPage extends StatefulWidget {
  final User user;
  final List<CardModel> cards;

  SharedCardsPage(this.user, this.cards);

  @override
  State<StatefulWidget> createState() {
    return SharedCardsPageState(user, cards);
  }
}

class SharedCardsPageState extends State<SharedCardsPage> {
  User user;
  List<CardModel> cards;
  SharedCardsPageController controller;
  PageController viewController = PageController(viewportFraction: 0.8);

  SharedCardsPageState(this.user, this.cards) {
    controller = SharedCardsPageController(this);
  }

  final TextStyle style = TextStyle(color: Colors.blue[800]);

  var currentPage = 0;

  @override
  void initState() {
    super.initState();
    viewController.addListener(() {
      int next = viewController.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: Colors.deepPurple[600],

      appBar: AppBar(
        title: Text('Shared cards'),
      ),
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: viewController,
        itemCount: cards.length,
        itemBuilder: (context, index) => Container( 
          color: Colors.grey[400],
          margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
          child: Card(
            color: Colors.white38,
            elevation: 10,
            shape: BeveledRectangleBorder(side: BorderSide(color: Colors.black, style: BorderStyle.solid)),
            borderOnForeground: true,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                                      child: CachedNetworkImage(
                      imageUrl: cards[index].imageUrl,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline),  
                    ),
                  ),
                  RaisedButton(
                    child: Text('Buy'),
                    onPressed: () {},
                  ),
                  Text('Author: ${cards[index].name}', style: style,),
                  Text('Publication Year: ${cards[index].strategyType}', style: style,),
                  Text('Created By: ${cards[index].createdBy}', style: style,),
                  Text('Last Updated: ${cards[index].lastUpdatedAt}', style: style,),
                  Text('Shared With: ${cards[index].sharedWith}', style: style,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}