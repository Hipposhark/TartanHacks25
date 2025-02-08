import 'package:flutter/material.dart';
import 'package:huddleup/consts.dart';
import 'package:uuid/uuid.dart';

class AppProvider extends ChangeNotifier {
  UserState userState = UserState(id: Uuid().v4().toString());

  String getUserId() {
    return userState.getUserId;
  }

  void setUserToOrganizer() {
    userState.setIsOrganizer(true);
    userState.setIsParticipant(false);

    OrganizerModel organizerModel = OrganizerModel();
    userState.setUserModel(organizerModel);

    notifyListeners();
  }

  void setUserToParticipant() {
    userState.setIsParticipant(true);
    userState.setIsOrganizer(false);

    ParticipantModel newParticipant = ParticipantModel();
    userState.setUserModel(newParticipant);

    notifyListeners();
  }

  // organizer methods
  void setOrganizerPrompt(String newPrompt) {
    userState.userModel.setPrompt = newPrompt;
    notifyListeners();
  }

  String getOrganizerPrompt() {
    return userState.userModel.getPrompt;
  }

  void setOrganizerTeamSize(int newTeamSize) {
    userState.userModel.setTeamSize = newTeamSize;
    notifyListeners();
  }

  int getOrganizerTeamSize() {
    return userState.userModel.getTeamSize;
  }

  void setOrganizerCode(String newCode) {
    userState.userModel.setCode = newCode;
    notifyListeners();
  }

  String getOrganizerCode() {
    return userState.userModel.getCode;
  }

  void setOrganizerTeams(List<Team> newTeams) {
    userState.userModel.setTeams = newTeams;
    notifyListeners();
  }

  List<Team> getOrganizerTeams() {
    return userState.userModel.getTeams;
  }

  // participant methods
  void setParticipantCode(String newCode) {
    userState.userModel.setCode = newCode;
    notifyListeners();
  }

  String getParticipantCode() {
    return userState.userModel.getCode;
  }

  void setParticipantName(String newName) {
    userState.userModel.setName = newName;
    notifyListeners();
  }

  String getParticipantName() {
    return userState.userModel.getName;
  }

  void setParticipantForm(List<FormQuestion> newForm) {
    userState.userModel.setForm = newForm;
    notifyListeners();
  }

  List<FormQuestion> getParticipantForm() {
    return userState.userModel.getForm;
  }

  void setParticipantResponses(List<FormQuestionResponse> newResponses) {
    userState.userModel.setResponses = newResponses;
    notifyListeners();
  }

  List<FormQuestionResponse> getParticipantResponses() {
    return userState.userModel.getResponses;
  }
}