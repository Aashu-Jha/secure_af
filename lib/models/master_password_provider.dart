import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasterPassword with ChangeNotifier{
  static const PASSWORD = 'PASSWORD';

  setMasterPassword(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PASSWORD, value);
  }

  Future<String> getMasterPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PASSWORD) ?? '';
  }
}

