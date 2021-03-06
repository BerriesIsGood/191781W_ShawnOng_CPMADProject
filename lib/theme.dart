import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _selectedTheme;

  ThemeData light = ThemeData.light().copyWith(
    primaryColor: Colors.teal[600],
    scaffoldBackgroundColor: Colors.blueAccent[100],
  );

  ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.blue,
  );

  ThemeProvider({bool isDarkMode}){
    _selectedTheme = isDarkMode ? dark : light;
  }

  Future<void> swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_selectedTheme == dark){
      _selectedTheme = light;
      prefs.setBool("isDarkTheme", false);
    }else{
      _selectedTheme = dark;
      prefs.setBool("isDarkTheme", true);
    }
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;
}