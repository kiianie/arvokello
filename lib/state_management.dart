import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
    String chosenLanguage = "";

    //Getters

    String get getLanguage => chosenLanguage;

    // Setters

    void setLanguage(String language){
        chosenLanguage = language;
        notifyListeners();
    }
}