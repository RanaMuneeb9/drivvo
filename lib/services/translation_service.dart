import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class TranslationService extends Translations {
  static final fallbackLocale = Locale('en', 'US');
  static final locales = [
    Locale('en', 'US'),
    Locale('ur', 'PK'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('ar', 'SA'),
    Locale('ja', 'JP'),
    Locale('de', 'DE'),
  ];

  Map<String, Map<String, String>> translations = {};

  Future<void> init() async {
    await _loadLanguage('en_US', 'assets/lang/en_US.json');
    await _loadLanguage('ur_PK', 'assets/lang/ur_PK.json');
    await _loadLanguage('es_ES', 'assets/lang/es_ES.json');
    await _loadLanguage('fr_FR', 'assets/lang/fr_FR.json');
    await _loadLanguage('ar_SA', 'assets/lang/ar_SA.json');
    await _loadLanguage('ja_JP', 'assets/lang/ja_JP.json');
    await _loadLanguage('de_DE', 'assets/lang/de_DE.json');
  }

  Future<void> _loadLanguage(String key, String path) async {
    try {
      translations[key] = await _loadJson(path);
    } catch (e) {
      debugPrint('Error loading $key translations from $path: $e');
      translations[key] = translations['en_US'] ?? {};
    }
  }

  Future<Map<String, String>> _loadJson(String path) async {
    try {
      final data = await rootBundle.loadString(path);
      final decoded = json.decode(data);
      if (decoded is Map) {
        return Map<String, String>.from(decoded);
      }
      debugPrint('Warning: Translation file $path is not a valid JSON map');
      return {};
    } on PlatformException catch (e) {
      debugPrint('Platform exception loading translation $path: $e');
      rethrow;
    } on FormatException catch (e) {
      debugPrint('JSON format error in translation $path: $e');
      return {}; // Return empty map on parse error
    } catch (e) {
      debugPrint('Unexpected error loading translation $path: $e');
      rethrow;
    }
  }

  @override
  Map<String, Map<String, String>> get keys => translations;
}
