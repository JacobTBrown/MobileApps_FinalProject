import 'package:flutter/material.dart';

import '../view/profilepage.dart';
import './myfirebase.dart';
import '../view/mydialog.dart';

class ProfilePageController {

  ProfilePageState state;

  ProfilePageController(this.state);

  String validateDisplayName(String value) {
    if (value == null || value.length < 3) {
      return 'Enter a display name with at least 3 chars';
    }
    return null;
  }

  void saveDisplayName(String value) {
    state.user.displayName = value;
  }

  String validateImageURL(String value) {
    if (value == null || !value.contains('http'))
      return 'Enter valid url';
    return null;
  }

  void saveImageURL(String value) {
    state.user.profileImage = value;
  }

  String validateEmail(String value) {
    if (value == null || !value.contains('.') || !value.contains('@')) {
      return 'Enter valid email address';
    }
    return null;
  }

  void saveEmail(String value) {
    state.user.email = value;
  }

  String validateCurrentPassword(String value) {
    if (value == null || value == '' || value != state.user.password) {
      return 'Enter the correct password';
    }
    return null;
  }

  void saveCurrentPassword(String value) {
  }

  String validateNewPassword(String value) {
    if (value == null || value == '') {
      return 'Enter a valid password';
    } else if (value == state.textEdit.text)
      return null;
    return null;
  }

  void saveNewPassword(String value) {
    if (value != state.textEdit.text)
      state.user.password = value;
  }

  String validateCountry(String value) {
    if (value == null || value == '') {
      return 'Enter a valid password';
    }
    return null;
  }

  void saveCountry(String value) {
    state.user.country = value;
  }

  String validateState(String value) {
    if (value == null || value == '') {
      return 'Enter a valid password';
    }
    return null;
  }

  void saveState(String value) {
    state.user.state = value;
  }

  void updateAccount() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }

    state.formKey.currentState.save();
    
    //update info 
    try {
      MyFirebase.updateInfo(state.user.uid, state.user);
      print('${state.user.uid}');
    } catch (e) {
      MyDialog.info(
        context: state.context,
        title: 'Update info failed!',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );
      return;
    }

    MyDialog.info(
        context: state.context,
        title: 'Update success!',
        message: 'Your info was updated successfully!',
        action: () => Navigator.pop(state.context),
      );
  }
}