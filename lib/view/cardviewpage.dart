import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tags/tag.dart';

import '../controller/cardviewpage_controller.dart';
import '../model/cardmodel.dart';
import '../model/user.dart';
import '../model/theme.dart';

class CardViewPage extends StatefulWidget {
  final User user;
  final CardModel card;
  final bool isShop;

  CardViewPage(this.user, this.card, this.isShop);

  @override
  State<StatefulWidget> createState() {
    return CardViewPageState(user, card, isShop);
  }
}

class CardViewPageState extends State<CardViewPage> {
  User user;
  CardModel card;
  CardModel cardCopy;
  CardViewPageController controller;

  var formKey = GlobalKey<FormState>();
  var textEdit;
  bool isShop;

  TextStyle labelStyle;
  TextStyle textStyle;

  CardViewPageState(this.user, this.card, this.isShop) {
    if (card == null) {
      cardCopy = CardModel.empty();
    } else {
      cardCopy = CardModel.clone(card);
    }
    controller = CardViewPageController(this);
    
    if(cardCopy.identityTags == null)
      cardCopy.identityTags = new List<dynamic>();

    textEdit = TextEditingController(text: cardCopy.description);
    controller.descriptionCharCount = cardCopy.description.length;

    Themes.setCardTheme(cardCopy.strategyType);

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
        title: Text('Card Details'),
        centerTitle: true,
      ),
      body: Theme(
        data: Themes.cardThemeData,
        child: Form(
          key: formKey,
                  child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  color: Themes.cardLightShade,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: Card(
                          elevation: 10,
                          color: Themes.card,
                          child: Stack(children: <Widget>[
                            Positioned(
                              //Card Artwork
                              left: 97,
                              bottom: 4,
                              top: 8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  width: 190,
                                  height: 340,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                    imageUrl: cardCopy.imageUrl,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      child:
                                          Icon(Icons.error_outline, size: 250),
                                    ),
                                    height: 300,
                                    width: 400,
                                  ),
                                ),
                              ),
                            ),
                            Image(
                              //Card Border
                              image: Themes.border,
                              height: 300,
                              width: 400,
                              alignment: Alignment.center,
                            ),
                            Positioned(
                              //Name
                              top: 19,
                              left: 114,
                              child: Text(
                                cardCopy.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Positioned(
                              //Atk
                              top: 24,
                              left: 236.5,
                              child: Text(
                                cardCopy.atk.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Positioned(
                              //Def
                              top: 24,
                              left: 260.5,
                              child: Text(
                                cardCopy.def.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Positioned(
                              //Turns left
                              top: 260.5,
                              left: 253,
                              child: Text(
                                cardCopy.turnsLeft.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Positioned(
                              //Description
                              top: 175,
                              left: 115,
                              child: Container(
                                width: 155,
                                child: Text(
                                  cardCopy.description,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Colors.black,
                                      backgroundColor: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            Positioned(
                              //Tags
                              top: 175,
                              left: 115,
                              child: Container(
                                width: 155,
                                child: Text(
                                  cardCopy.description,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Colors.black,
                                      backgroundColor: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            Positioned(
                              //Price
                              top: 5,
                              left: 5,
                              child: Row(children: <Widget>[
                                Text(
                                  'Price: \$',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  cardCopy.price.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                            ),
                          ]),
                        ),
                      ),
                      TextFormField(
                        initialValue: cardCopy.imageUrl,
                        enabled: (user.isAdmin == null || user.isAdmin == false) ? false : true,
                        style: textStyle,
                        decoration: InputDecoration(
                          labelText: 'Image Url:',
                          labelStyle: labelStyle,
                        ),
                        validator: controller.validateImageUrl,
                        onSaved: controller.saveImageUrl,
                      ),
                      TextFormField(
                        initialValue: cardCopy.name,
                        enabled: (user.isAdmin == null || user.isAdmin == false) ? false : true,
                        style: textStyle,
                        decoration: InputDecoration(
                          labelText: 'Name:',
                          labelStyle: labelStyle,
                        ),
                        validator: controller.validateName,
                        onSaved: controller.saveName,
                      ),
                      TextFormField(
                        initialValue: cardCopy.price.toString(),
                        enabled: (user.isAdmin == null || user.isAdmin == false) ? false : true,
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Price: \$',
                          labelStyle: labelStyle,
                        ),
                        validator: controller.validatePrice,
                        onSaved: controller.savePrice,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Text(
                                      'Theme:',
                                      style: TextStyle(
                                          color: Themes.card,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Themes.cardLightShade,
                                    ),
                                    child: DropdownButton<String>(
                                      value: cardCopy.strategyType,
                                      disabledHint: Text(cardCopy.strategyType),
                                      style: TextStyle(color: Themes.cardDarkShade, fontWeight: FontWeight.w400),
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 15,
                                      elevation: 16,
                                      underline: Container(
                                        height: 2,
                                        color: Themes.cardLightAccent,
                                      ),
                                      onChanged: (user.isAdmin == null || user.isAdmin == false) ? null : (String newValue) {
                                          setState(() {
                                            controller.dropdownStratValue = newValue;
                                            controller.saveStrategyType(newValue);

                                            Themes.setCardTheme(newValue);
                                            labelStyle = TextStyle(color: Themes.card, fontSize: 20, fontWeight: FontWeight.w600);
                                            textStyle = TextStyle(color: Themes.cardDarkShade, fontWeight: FontWeight.w300);
                                          });
                                        },
                                      items: <String>[
                                        'Power',
                                        'Survival',
                                        'Nobility',
                                        'Diplomacy',
                                        'Growth',
                                        'Faith'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: textStyle,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Text(
                                      'Type:',
                                      style: TextStyle(
                                          color: Themes.card,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Themes.cardLightShade,
                                    ),
                                    child: DropdownButton<String>(
                                      value: cardCopy.combatType,
                                      disabledHint: Text(cardCopy.combatType),
                                      style: TextStyle(color: Themes.cardDarkShade, fontWeight: FontWeight.w400),
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 15,
                                      elevation: 16,
                                      underline: Container(
                                        height: 2,
                                        color: Themes.cardLightAccent,
                                      ),
                                      onChanged: (user.isAdmin == null || user.isAdmin == false) ? null : (String newValue) {
                                          setState(() {
                                            controller.dropdownCombatValue = newValue;
                                            controller.saveCombatType(newValue);
                                            //cardCopy.type = controller.dropdownTypeValue;
                                          });
                                        },
                                      items: <String>[
                                        'Physical',
                                        'Magical',
                                        'Ranged',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: textStyle,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      TextField(
                        autocorrect: false,
                        enabled: (user.isAdmin == null || user.isAdmin == false) ? false : true,
                        maxLines: 5,
                        maxLength: 225,
                        maxLengthEnforced: true,
                        style: textStyle,
                        cursorColor: Themes.card,
                        controller: textEdit,
                        onChanged: (String value) {      
                          setState(() {
                            controller.descriptionCharCount = value.length;
                          });
                        },
                        decoration: InputDecoration(
                          counterText: 'Character Count: ${controller.descriptionCharCount}',
                          counterStyle: TextStyle(color: Themes.card, fontWeight: FontWeight.w500),
                          labelText: 'Description',
                          labelStyle: TextStyle(
                              color: Themes.card,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(),
                              borderSide: BorderSide())
                        ),
                      ),
                      TextFormField(
                        initialValue: cardCopy.sharedWith.join(',').toString(),
                        enabled: (user.isAdmin == null || user.isAdmin == false) ? false : true,
                        style: textStyle,
                        decoration: InputDecoration(
                          labelText: 'Shared with:',
                          labelStyle: labelStyle,
                        ),
                        autocorrect: false,
                        validator: controller.validateSharedWith,
                        onSaved: controller.saveStrategyType,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('Tags:', style: TextStyle(
                                          color: Themes.card,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),)
                      ),
                      Container(
                        child: Tags(
                          key: Key('viewtaglist'),
                          textField: TagsTextField(
                            onSubmitted: (String str) {
                              stateChanged(() {
                                ItemTags tag = ItemTags(key: Key(controller.tags.length.toString()), index: controller.tags.length, title: str,);
                                controller.tags.add(tag);
                              });
                            }
                          ),
                          itemCount: controller.tags.length,
                          itemBuilder: (int index) {
                            final item = controller.tags[index];
                            return ItemTags(
                              key: Key(item+index.toString()),
                              index: index,
                              title: item,
                              active: true,
                              singleItem: false,
                              padding: EdgeInsets.all(5),
                              color: Themes.cardDarkAccent,
                              activeColor: Themes.card,
                              textColor: Colors.black,
                              textActiveColor: Colors.white,
                              removeButton: ItemTagsRemoveButton(icon: Icons.remove_circle_outline),
                              onRemoved: () { stateChanged(() { controller.tags.removeAt(index); }); },
                              onPressed: (Item item) { controller.onTagPressed(item); },
                            );
                          },
                          columns: 5,
                        )
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              'Created by: ' + cardCopy.createdBy,
                              style: textStyle,
                            ),
                            Text(
                              'Last Update: ' +
                                  cardCopy.lastUpdatedAt.toString(),
                              style: textStyle,
                            ),
                            Text(
                              'DocumentID: ' + cardCopy.documentId.toString(),
                              style: textStyle,
                            ),
                          ],
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
                  child: isShop ? controller.returnWidget() : Text('Close'),
                  onPressed: isShop ? () {
                    if (user.isAdmin == null || user.isAdmin == false) {
                      controller.buy();
                    } else {
                      controller.save();
                    }
                  } : () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
