import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class TranslationService extends Translations {
  static final fallbackLocale = Locale('en', 'US');
  static final locales = [Locale('en', 'US'), Locale('ur', 'PK')];

  Map<String, Map<String, String>> translations = {};

  Future<void> init() async {
    try {
      translations['en_US'] = await _loadJson('assets/lang/en_US.json');
    } catch (e) {
      debugPrint('Error loading en_US translations: $e');
      translations['en_US'] = {}; // Fallback to empty map
    }

    try {
      translations['ur_PK'] = await _loadJson('assets/lang/ur_PK.json');
    } catch (e) {
      debugPrint('Error loading ur_PK translations: $e');
      // Fallback to English if Urdu fails to load
      translations['ur_PK'] = translations['en_US'] ?? {};
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
