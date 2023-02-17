
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'en_us.dart';
import 'fr_fra.dart';

class TranslationService extends Translations {
  static Locale? get locale => Locale('en', 'US'); ///for eng
  //static Locale? get locale => Locale('fr', 'FRA'); /// for franch
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'fr_FRA': fr_FRA,
      };
}
