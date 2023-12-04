import 'package:flutter/material.dart';
import 'package:todo_listapp/app/config/prefs/prefs.dart';

class Global {
  static late UserPrefences prefs;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await UserPrefences().init();
  }
}