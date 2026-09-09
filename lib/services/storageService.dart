import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/loadRecord.dart';

class StorageService {
  static const String _historyKey = 'load_history';

  static Future<void> saveRecord(LoadRecord record) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_historyKey) ?? [];

    history.add(jsonEncode(record.toJson()));

    await prefs.setStringList(_historyKey, history);
  }

  static Future<List<LoadRecord>> getRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_historyKey) ?? [];

    return history
        .map((item) => LoadRecord.fromJson(jsonDecode(item)))
        .toList()
        .reversed
        .toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  static Future<void> deleteRecord(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> history = prefs.getStringList(_historyKey) ?? [];

    history.removeWhere((item) {
      final decoded = LoadRecord.fromJson(jsonDecode(item));
      return decoded.id == id;
    });

    await prefs.setStringList(_historyKey, history);
  }
}