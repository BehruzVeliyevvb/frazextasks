import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('az'),
    const Locale('en'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'az':
        return '🇦🇿';
      case 'en':
        return '🇺🇸';
      default:
        return '🇺🇸';
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
