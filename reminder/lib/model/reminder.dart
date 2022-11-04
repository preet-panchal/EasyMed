import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Reminder {
  int? id;
  String? name;
  String? instructions;

  Reminder({this.id, this.name, this.instructions});

  factory Reminder.fromMap(Map map) {
    return Reminder(
      id: map['id'],
      name: map['name'],
      instructions: map['instructions'],
    );
  }

  Map<String,Object?> toMap() {
    return {
      'id':id,
      'name':name,
      'instructions':instructions
    };
  }

  String toString() {
    return "Reminder[id: $id], name: $name, instruction: $instructions";
  }
}