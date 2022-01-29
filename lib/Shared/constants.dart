import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// App Primary Color
const primaryAppColor = Colors.black;

//Card Colors
Color onlineTextColor = Colors.black;
Color offlineTextColor = Colors.black;
Color onlineCardColor = Colors.white;
Color offlineCardColor = Colors.white;

// input Decoration for Forms
const inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.black12,
  focusColor: primaryAppColor,
  labelStyle: TextStyle(

  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.transparent,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryAppColor,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    )
);
