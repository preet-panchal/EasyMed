import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Reminder {
  int? id;
  String? name;
  String? instructions;
  String? usage;
  String? date;
  String? time;

  Reminder(
      {this.id,
      this.name,
      this.instructions,
      this.usage,
      this.date,
      this.time});

  factory Reminder.fromMap(Map map) {
    return Reminder(
        id: map['id'],
        name: map['name'],
        instructions: map['instructions'],
        usage: map['usage'],
        date: map['date'],
        time: map['time']);
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'instructions': instructions,
      'usage': usage,
      'date': date,
      'time': time
    };
  }

  String toString() {
    return "Reminder[id: $id], name: $name, instruction: $instructions, usage: $usage, date: $date, time: $time";
  }
}
