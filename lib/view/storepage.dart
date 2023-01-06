import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../model/cardmodel.dart';
import '../model/theme.dart';
import '../controller/storepage_controller.dart';

class StorePage extends StatefulWidget {
  final User user;
  final List<CardModel> storeCardsList;

  StorePage(this.user, this.storeCardsList);

  @override
  State<StatefulWidget> createState() {
    return StorePageState(user, storeCardsList);
  }
}

class StorePageState extends State<StorePage> {
  User user;
  List<CardModel> storeCardsList;
  List<int> deleteIndices;

  StorePageController controller;
  BuildContext context;

  var formKey = GlobalKey<FormState>();
  var textEdit = new TextEditingController();

  StorePageState(this.user, this.storeCardsList) {
    controller = StorePageController(this);
    controller.sortCards(controller.searchCardList);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      onWillPop: () {
        (user.isAdmin == null || user.isAdmin == false) ? Navigator.pop(context) : null;
        return Future.value(true);
      },
          child: Scaffold(
          appBar: AppBar(
            title: Text('Store'),
            actions: (deleteIndices != null)
                ? <Widget>[
                    FlatButton.icon(
                      label: Text('Delete'),
                      icon: Icon(Icons.delete_forever),
                      onPressed: controller.deleteButton,
                    )
                  ]
                : null
          ),
          floatingActionButton: (user.isAdmin == null || user.isAdmin == false) ? null : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: controller.addButton,
          ),
          body: Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  child: Form(
                    key: formKey,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: textEdit,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: "Enter a card name",
                              labelText: 'Search Store',
                            ),
                            validator: controller.validateUser,
                            onSaved: controller.saveUser,
                            onChanged: (value) => {
                              stateChanged(() {
                                controller.findCards(value);
                                if (value.isEmpty)
                                  controller.sortCards(controller.searchCardList);
                              })
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Themes.mainDarkAccent,),
                          hoverColor: Colors.orange,
                          onPressed: () => controller.findCards(textEdit.value.text),
                        ),
                        (user.isAdmin == null || user.isAdmin == false) ? Text('Points: \$${user.points}') : Text('')
                      ],
                    )),
                ),
                Divider(thickness: 4,),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: .75, crossAxisCount: 5),
                    itemCount: controller.searchCardList.length,
                    itemBuilder: (context, index) => Container(
                      child: GestureDetector(
                        onTap: () {
                          controller.onTap(index);
                        },
                        onLongPress: () {
                          controller.longPress(index);
                        },
                        child: Card(
                              color: Themes.getCardColoring(controller.searchCardList[index].strategyType),
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
                                      imageUrl: controller.searchCardList[index].imageUrl,
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
                                        '${controller.searchCardList[index].name}',
                                        style: TextStyle(color: Themes.mainDarkShade),
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
            ),
          )),
    );
  }
}
