import 'package:flutter/material.dart';

import '../view/suggestionpage.dart';
import '../view/mydialog.dart';

class SuggestionPageController {
  SuggestionPageState state;

  SuggestionPageController(this.state) {
    dropdownValue = 'Suggestion';
  }

  int descriptionCharCount = 0;
  String description;
  String dropdownValue;

  void saveDescription(String value) {
    description = value;
  }

  void saveDropdown(String value) {
    dropdownValue = value;
  }

  void save() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();

    MyDialog.info(
      context: state.context,
      title: 'Sorry!',
      message: "It does not work yet.",
      action: () => Navigator.pop(state.context),
    );
  }
}
