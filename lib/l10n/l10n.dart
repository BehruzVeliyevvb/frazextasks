import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('az'),
    const Locale('en'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'az':
        return 'π¦πΏ';
      case 'en':
        return 'πΊπΈ';
      default:
        return 'πΊπΈ';
    }
  }

  static String getName(String code) {
    switch (code) {
      case 'az':
        return 'Azerbaycan Dili';
      case 'en':
        return 'English';
      default:
        return 'English';
    }
  }
}
