import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static void showToast(String error, MaterialColor color) {
    Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class AppToast {
//   static void showToast(String error, MaterialColor color) {
//     Fluttertoast.showToast(
//       msg: error,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.TOP,
//       backgroundColor: color,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
// }
