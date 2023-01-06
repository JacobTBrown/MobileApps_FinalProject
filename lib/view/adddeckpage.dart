import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';

import '../controller/adddeckpage_controller.dart';
import '../model/user.dart';
import '../model/theme.dart';

class AddDeckPage extends StatefulWidget {
  final User user;
  final List<dynamic> storeCardList;

  AddDeckPage(this.user, this.storeCardList);

  @override
  State<StatefulWidget> createState() {
    return AddDeckPageState(user, storeCardList);
  }
}

class AddDeckPageState extends State<AddDeckPage> {
  User user;
  List<dynamic> storeCardList;
  AddDeckPageController controller;

  var formKey = GlobalKey<FormState>();
  var textEdit = new TextEditingController();

  TextStyle labelStyle;
  TextStyle textStyle;

  AddDeckPageState(this.user, this.storeCardList) {
    controller = AddDeckPageController(this);
    controller.cardList = new List<dynamic>();
    controller.addTags();

    //Themes.setCardTheme(cardCopy.strategyType);

    labelStyle = TextStyle(
        color: Themes.card, fontSize: 20, fontWeight: FontWeight.w600);
    textStyle =
        TextStyle(color: Themes.cardDarkShade, fontWeight: FontWeight.w300);
    //dropdownStyle = TextStyle(color: Themes.)
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deck Details'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Expanded(flex: 1,
              child: Container(
                width: 1500,
                height: 500,
                padding: EdgeInsets.only(left: 10, right: 10),
                color: Themes.mainLightShade,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      width: 1500,
                      height: 125,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,      
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2.5, crossAxisCount: 1),
                        shrinkWrap: true,
                        itemCount: controller.cardList.length,
                        itemBuilder: (context, index) => Container(
                          color: Themes.getCardColoring(controller.getDeckColor(index)),
                          child: CachedNetworkImage(
                            imageUrl: controller.getDeckImageUrl(index),
                            placeholder: (context, url) =>
                              CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline, size: 50),
                            height: 50,
                            width: 50,
                          ),
                        )),
                    ),
                    TextFormField(
                      initialValue: '',
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: 'Name:',
                        labelStyle: labelStyle,
                      ),
                      autocorrect: false,
                      validator: controller.validateName,
                      onSaved: controller.saveName,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          'Tags:',
                          style: TextStyle(
                              color: Themes.card,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        )),
                    /*Container(
                      child: SelectableTags(
                        singleItem: false,
                        onPressed: (tag) => controller.onTagPressed(tag),
                        backgroundContainer: Themes.cardLightShade,
                        color: Themes.card,
                        tags: controller.tags,
                      ),
                    ),*/
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: .75, crossAxisCount: 5),
                      itemCount: user.cardsList.length,
                      itemBuilder: (context, index) => Container(
                        child: GestureDetector(
                          onTap: () {
                            controller.onTap(index);
                            stateChanged(() {});
                          },
                          child: Card(
                              color: Themes.getCardColoring(
                                  controller.getCardColor(index)),
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
                                              controller.getCardImageUrl(index),
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
                                            '${controller.getCardName(index)}',
                                            style: TextStyle(
                                                color: Themes.mainDarkShade),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: 800,
              color: Themes.cardLightShade,
              child: RaisedButton(
                color: Themes.cardLightAccent,
                child: Text('Save'),
                onPressed: controller.save,
              ),
            )
          ],
        ),
      ),
    );
  }
}
