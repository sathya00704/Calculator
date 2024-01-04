import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.blueGrey,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2)
  ),
  hintStyle: TextStyle(color: Colors.white),
);
