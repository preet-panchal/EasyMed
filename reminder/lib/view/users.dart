import 'package:flutter/material.dart';

class Users {
  // final int id;
  final String imagePath;
  final String fullName;
  final String dateOfBirth;
  final String email;
  final String phone;
  final String healthID;

  const Users({
    // required this.id,
    required this.imagePath,
    required this.fullName,
    required this.dateOfBirth,
    required this.email,
    required this.phone,
    required this.healthID
  });
}
