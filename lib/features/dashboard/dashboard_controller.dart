import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_manager/models/password_entry.dart';

class DashboardController extends ChangeNotifier {
  final Box<PasswordEntry> _passwordBox = Hive.box<PasswordEntry>('passwords');

  // Track hidden/visible state
  final Map<String, bool> _hidden = {};

  DashboardController() {
    for (var entry in _passwordBox.values) {
      _hidden[entry.id] = true;
    }
  }

  List<PasswordEntry> get passwords => _passwordBox.values.toList();

  bool isHidden(String id) => _hidden[id] ?? true;

  void toggleVisibility(String id) {
    _hidden[id] = !(_hidden[id] ?? true);
    notifyListeners();
  }

  void addEntry(PasswordEntry entry) {
    _passwordBox.add(entry);
    _hidden[entry.id] = true;
    notifyListeners();
  }

  void updateEntry(int index, PasswordEntry entry) {
    _passwordBox.putAt(index, entry);
    notifyListeners();
  }

  void deleteEntry(int index, String id) {
    _passwordBox.deleteAt(index);
    _hidden.remove(id);
    notifyListeners();
  }
}
