import 'package:flutter/material.dart';

class SelectedPageProvider extends ChangeNotifier {
  int selectedPage;
  bool isAuthenticated;
  SelectedPageProvider({
    this.selectedPage = 0,
    this.isAuthenticated = false,
  });
  void changePage(int newValue) {
    selectedPage = newValue;
    notifyListeners();
  }

  void setAuth(bool value) {
    isAuthenticated = value;
  }
}
