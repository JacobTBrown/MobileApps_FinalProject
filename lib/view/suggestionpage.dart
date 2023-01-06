import 'package:CMD/model/theme.dart';
import 'package:flutter/material.dart';

import '../controller/suggestionpage_controller.dart';
import '../model/user.dart';

class SuggestionPage extends StatefulWidget {
  final User user;

  SuggestionPage(this.user);

  @override
  State<StatefulWidget> createState() {
    return SuggestionPageState(user);
  }
}

class SuggestionPageState extends State<SuggestionPage> {
  SuggestionPageController controller;
  BuildContext context;
  User user;

  var formKey = GlobalKey<FormState>();
  var textEdit = new TextEditingController();

  TextStyle labelStyle;
  TextStyle textStyle;

  SuggestionPageState(this.user) {
    controller = SuggestionPageController(this);

    labelStyle = TextStyle(
        color: Themes.card, fontSize: 20, fontWeight: FontWeight.w600);
    textStyle = TextStyle(
        color: Themes.cardLightShade,
        fontSize: 12.5,
        fontWeight: FontWeight.w400,
        wordSpacing: 1.1);
  }

  void stateChanged(Function fn) {
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestions/Problems'),
      ),
      body: Container(
        color: Color.fromRGBO(55, 55, 55, 1),
        padding: EdgeInsets.all(5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Form(
                  key: formKey,
                  child: ListView(
                    shrinkWrap: false,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        alignment: Alignment.topCenter,
                        child: TextField( //Description form
                          autocorrect: false,
                          maxLines: 20,
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
                                  color: Themes.card,
                                  fontWeight: FontWeight.w500),
                              labelText: 'Suggestions, Problems and Comments',
                              labelStyle: TextStyle(
                                  color: Themes.card,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(),
                                  borderSide: BorderSide())),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButton<String>(
                                value: controller.dropdownValue,
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 15,
                                elevation: 16,
                                underline: Container(
                                  height: 2,
                                  color: Themes.cardLightAccent,
                                ),
                                onChanged: (String newValue) {
                                  setState(() { controller.saveDropdown(newValue); });
                                },
                                items: <String>[
                                  'Suggestion',
                                  'Problem',
                                  'Comment',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: textStyle,
                                    ),
                                  );
                                }).toList(),
                              ))
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: 800,
                        child: RaisedButton(
                          color: Themes.cardLightAccent,
                          child: Text('Save'),
                          onPressed: controller.save,
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
