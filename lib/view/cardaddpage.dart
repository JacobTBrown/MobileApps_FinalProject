import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tags/tag.dart';

import '../controller/cardaddpage_controller.dart';
import '../model/cardmodel.dart';
import '../model/descriptors.dart';
import '../model/user.dart';
import '../model/theme.dart';

class CardAddPage extends StatefulWidget {
  final User user;
  final CardModel card;

  CardAddPage(this.user, this.card);

  @override
  State<StatefulWidget> createState() {
    return CardAddPageState(user, card);
  }
}

class CardAddPageState extends State<CardAddPage> {
  User user;
  CardModel card;
  CardModel cardCopy;
  CardAddPageController controller;

  var formKey = GlobalKey<FormState>();
  var textEdit = new TextEditingController();

  TextStyle labelStyle;
  TextStyle textStyle;

  CardAddPageState(this.user, this.card) {
    controller = CardAddPageController(this);
    if (card == null) {
      cardCopy = CardModel.empty();
    } else {
      cardCopy = CardModel.clone(card);
    }

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
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          //Image URL form
                          initialValue: cardCopy.imageUrl,
                          style: textStyle,
                          decoration: InputDecoration(
                            labelText: 'Image Url:',
                            labelStyle: labelStyle,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Themes.cardLightAccent, width: 2.5)),
                          ),
                          autocorrect: false,
                          validator: controller.validateImageUrl,
                          onSaved: controller.saveImageUrl,
                          onChanged: (String v) {
                            setState(() {
                              cardCopy.imageUrl = v;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            //Name form
                            flex: 3,
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 5, right: 5, top: 5),
                              child: TextFormField(
                                initialValue: cardCopy.name,
                                style: textStyle,
                                maxLength: 16,
                                maxLengthEnforced: true,
                                decoration: InputDecoration(
                                  labelText: 'Name:',
                                  labelStyle: labelStyle,
                                  counterStyle:
                                      TextStyle(color: Themes.cardLightAccent),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Themes.cardLightAccent,
                                          width: 2.5)),
                                ),
                                autocorrect: false,
                                validator: controller.validateName,
                                onSaved: controller.saveName,
                                onChanged: (String v) {
                                  setState(() {
                                    cardCopy.name = v;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            //Turns left form
                            flex: 2,
                            child: Container(
                              padding:
                                  EdgeInsets.only(right: 5, left: 5, top: 5),
                              child: TextFormField(
                                initialValue: cardCopy.turnsLeft.toString(),
                                enabled: (user.isAdmin == null ||
                                        user.isAdmin == false)
                                    ? false
                                    : true,
                                style: textStyle,
                                maxLength: 1,
                                maxLengthEnforced: true,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Turns Left:',
                                  labelStyle: labelStyle,
                                  counterStyle:
                                      TextStyle(color: Themes.cardLightAccent),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Themes.cardLightAccent,
                                          width: 2.5)),
                                ),
                                validator: controller.validatePrice,
                                onSaved: controller.savePrice,
                                onChanged: (String v) {
                                  setState(() {
                                    cardCopy.atk = int.parse(v);
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            //ATK form
                            flex: 1,
                            child: Container(
                              padding:
                                  EdgeInsets.only(right: 5, left: 5, top: 5),
                              child: TextFormField(
                                initialValue: cardCopy.atk.toString(),
                                style: textStyle,
                                maxLength: 2,
                                maxLengthEnforced: true,
                                decoration: InputDecoration(
                                  labelText: 'ATK:',
                                  labelStyle: labelStyle,
                                  counterStyle:
                                      TextStyle(color: Themes.cardLightAccent),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Themes.cardLightAccent,
                                          width: 2.5)),
                                ),
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                //validator: controller.validateName,
                                //onSaved: controller.saveName,
                                onChanged: (String v) {
                                  setState(() {
                                    cardCopy.atk = int.parse(v);
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            //DEF form
                            flex: 1,
                            child: Container(
                              padding:
                                  EdgeInsets.only(right: 5, left: 5, top: 5),
                              child: TextFormField(
                                initialValue: cardCopy.def.toString(),
                                style: textStyle,
                                maxLength: 2,
                                maxLengthEnforced: true,
                                decoration: InputDecoration(
                                  labelText: 'DEF:',
                                  labelStyle: labelStyle,
                                  counterStyle:
                                      TextStyle(color: Themes.cardLightAccent),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Themes.cardLightAccent,
                                          width: 2.5)),
                                ),
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                //validator: controller.validateName,
                                //onSaved: controller.saveName,
                                onChanged: (String v) {
                                  setState(() {
                                    cardCopy.def = int.parse(v);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //Theme/Type/Myth form
                        margin: EdgeInsets.only(top: 3),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                      child: Text(
                                        'Theme:',
                                        style: TextStyle(
                                            color: Themes.card,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Themes.cardLightShade,
                                      ),
                                      child: DropdownButton<String>(
                                        value: controller.dropdownStratValue,
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 15,
                                        elevation: 16,
                                        underline: Container(
                                          height: 2,
                                          color: Themes.cardLightAccent,
                                        ),
                                        style: TextStyle(fontSize: 11),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            controller
                                                .saveStrategyType(newValue);

                                            Themes.setCardTheme(newValue);
                                            labelStyle = TextStyle(
                                                color: Themes.card,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600);
                                            textStyle = TextStyle(
                                                color: Themes.cardDarkShade,
                                                fontWeight: FontWeight.w300);
                                          });
                                        },
                                        items: <String>[
                                          Descriptors.getThemePower(),
                                          Descriptors.getThemeSurvival(),
                                          Descriptors.getThemeNobility(),
                                          Descriptors.getThemeDiplomacy(),
                                          Descriptors.getThemeGrowth(),
                                          Descriptors.getThemeFaith()
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
                              //Type form
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                      child: Text(
                                        'Type:',
                                        style: TextStyle(
                                            color: Themes.card,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Themes.cardLightShade,
                                      ),
                                      child: DropdownButton<String>(
                                        value: controller.dropdownCombatValue,
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 15,
                                        elevation: 16,
                                        style: TextStyle(fontSize: 11),
                                        underline: Container(
                                          height: 2,
                                          color: Themes.cardLightAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            controller.saveCombatType(newValue);
                                            //cardCopy.type = controller.dropdownTypeValue;
                                          });
                                        },
                                        items: <String>[
                                          Descriptors.getTypePhysical(),
                                          Descriptors.getTypeMagical(),
                                          Descriptors.getTypeRanged()
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
                                margin: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                                      child: Text(
                                        'Myth:',
                                        style: TextStyle(
                                            color: Themes.card,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Themes.cardLightShade,
                                      ),
                                      child: DropdownButton<String>(
                                        value: controller.dropdownMythValue,
                                        icon: Icon(Icons.arrow_downward),
                                        iconSize: 15,
                                        elevation: 16,
                                        style: TextStyle(fontSize: 11),
                                        underline: Container(
                                          height: 2,
                                          color: Themes.cardLightAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            controller.saveMyth(newValue);
                                          });
                                        },
                                        items: <String>[
                                          Descriptors.getMythGreek(),
                                          Descriptors.getMythNorse(),
                                          Descriptors.getMythEgyptian()
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
                          ],
                        ),
                      ),
                      Container(
                        //Description form
                        padding: EdgeInsets.only(top: 10, right: 5, left: 5),
                        child: TextField(
                          autocorrect: false,
                          maxLines: 5,
                          maxLength: 225,
                          maxLengthEnforced: true,
                          style: textStyle,
                          cursorColor: Themes.card,
                          controller: textEdit,
                          onChanged: (String value) {
                            setState(() {
                              controller.descriptionCharCount = value.length;
                              controller.saveDescription(textEdit.value.text);
                            });
                          },
                          decoration: InputDecoration(
                            counterText:
                                'Character Count: ${controller.descriptionCharCount}',
                            counterStyle: TextStyle(
                                color: Themes.cardLightAccent,
                                fontWeight: FontWeight.w500),
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                color: Themes.card,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            border: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2.5),
                                borderSide: BorderSide(
                                    width: 2.5, style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Themes.cardLightAccent,
                                    width: 2.5,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(2.5)),
                          ),
                        ),
                      ),
                      Container(
                        //Price form
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        child: TextFormField(
                          initialValue: cardCopy.price.toString(),
                          enabled:
                              (user.isAdmin == null || user.isAdmin == false)
                                  ? false
                                  : true,
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Price (\$):',
                            labelStyle: labelStyle,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Themes.cardLightAccent, width: 2.5)),
                          ),
                          validator: controller.validatePrice,
                          onSaved: controller.savePrice,
                        ),
                      ),
                      Container(
                        //Shared With form
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          initialValue:
                              cardCopy.sharedWith.join(',').toString(),
                          style: textStyle,
                          decoration: InputDecoration(
                            labelText: 'Shared with:',
                            labelStyle: labelStyle,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Themes.cardLightAccent, width: 2.5)),
                          ),
                          autocorrect: false,
                          validator: controller.validateSharedWith,
                          onSaved: controller.saveSharedWith,
                        ),
                      ),
                      Container(
                          //Tags label
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            'Tags:',
                            style: TextStyle(
                                color: Themes.card,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )),
                      Container(
                        //Tags selectable
                        margin: EdgeInsets.only(bottom: 5),
                        child: Tags(
                          key: Key('addtaglist'),
                          itemCount: controller.tags.length,
                          itemBuilder: (int index) {
                            final item = controller.tags[index];
                            return ItemTags(
                              key: Key(item + index.toString()),
                              index: index,
                              title: item,
                              active: true,
                              singleItem: false,
                              padding: EdgeInsets.all(5),
                              color: Themes.cardDarkAccent,
                              activeColor: Themes.card,
                              textColor: Colors.black,
                              textActiveColor: Colors.white,
                              removeButton: ItemTagsRemoveButton(
                                  icon: Icons.remove_circle_outline),
                              onRemoved: () {
                                stateChanged(() {
                                  controller.tags.removeAt(index);
                                });
                              },
                              onPressed: (Item item) {
                                controller.onTagPressed(item);
                              },
                            );
                          },
                          columns: 5,
                        ),
                      ),
                      Container(
                        //Info
                        padding: EdgeInsets.all(5),
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
                  child: Text('Save'),
                  onPressed: controller.save,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
