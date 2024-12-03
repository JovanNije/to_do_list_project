import 'dart:math';
import 'package:flutter/material.dart';

// Function to generate random bright colors
  Color _generateRandomBrightColor() {
    final random = Random();
    int red = random.nextInt(106) + 150;
    int green = random.nextInt(106) + 150;
    int blue = random.nextInt(106) + 150;
    return Color.fromRGBO(red, green, blue, 1);
  }