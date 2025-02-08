import 'package:flutter/material.dart';

class PromptProvider extends ChangeNotifier {

  String _prompt = '';
  int _teamSize = 2;

  String get prompt => _prompt;
  int get teamSize => _teamSize;

  void setPrompt(String newPrompt) {
    _prompt = newPrompt;
    notifyListeners();
  }

  void setTeamSize(int newTeamSize) {
    _teamSize = newTeamSize;
    notifyListeners();
  }

}