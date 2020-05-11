import 'package:flutter/material.dart';

class Challenge {
  final UniqueKey id;
  String name = "";
  String description = "";
  DateTime dateTime = DateTime.now();
  bool done = false;

  Challenge() : this.id = UniqueKey();
}