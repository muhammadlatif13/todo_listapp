import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.grey,
    fontSize: 18,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.black,
  );
}
