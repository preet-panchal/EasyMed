import 'package:flutter/material.dart';

class User {
  // final int id;
  final String imagePath;
  final String fullName;
  final String dateOfBirth;
  final String email;
  final String phone;
  final String healthID;

  const User({
    // required this.id,
    required this.imagePath,
    required this.fullName,
    required this.dateOfBirth,
    required this.email,
    required this.phone,
    required this.healthID
  });
}
