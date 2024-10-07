import 'package:flutter/material.dart';

class FavouriteItemProvider extends ChangeNotifier {
  List<int> _selectedItems = [];

  List<int> get selectedItems => _selectedItems;

  bool isItemSelected(int id) {
    return _selectedItems.contains(id);
  }

  void addItem(int id) {
    _selectedItems.add(id);
    notifyListeners();
  }

  void removeItem(int id) {
    _selectedItems.remove(id);
    notifyListeners();
  }
}
