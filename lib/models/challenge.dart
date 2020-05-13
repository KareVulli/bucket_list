import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Challenge {
  String uid;
  String name = "";
  String description = "";
  DateTime dateTime = DateTime.now();
  bool done = false;

  Challenge();

  Challenge.fromJson(Map<String, dynamic> json) :
    this.uid = json['id'],
    this.name = json['name'],
    this.description = json['description'],
    this.dateTime = DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
    this.done = json['done'];

  Challenge.fromSnapshot(DocumentSnapshot document):
    this.uid = document.documentID,
    this.name = document.data['name'],
    this.description = document.data['description'],
    this.dateTime = DateTime.fromMillisecondsSinceEpoch(document.data['dateTime']),
    this.done = document.data['done'];


  Map<String, dynamic> toJson() =>
  {
    'name': name,
    'description': description,
    'dateTime': dateTime.millisecondsSinceEpoch,
    'done': done,
  };
}