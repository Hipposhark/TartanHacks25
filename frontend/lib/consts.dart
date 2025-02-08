class UserState {
  final String id;
  bool _isOrganizer = false;
  bool _isParticipant = false;
  dynamic _userModel;

  UserState({
    required this.id,
  });

  String get getUserId => id;
  bool get isOrganizer => _isOrganizer;
  bool get isParticipant => _isParticipant;
  dynamic get userModel => _userModel;

  void setIsOrganizer(bool isOrganizer){
    _isOrganizer = isOrganizer;
  }

  void setIsParticipant(bool isParticipant){
    _isParticipant = isParticipant;
  }

  void setUserModel(dynamic userModel){
    _userModel = userModel;
  }
}

class OrganizerModel {
  String prompt = '';
  int teamSize = 2;
  String code = '';
  List<Team> teams = [];

  String get getPrompt => prompt;
  set setPrompt(String prompt) => this.prompt = prompt;

  int get getTeamSize => teamSize;
  set setTeamSize(int teamSize) => this.teamSize = teamSize;

  String get getCode => code;
  set setCode(String code) => this.code = code;

  List<Team> get getTeams => teams;
  set setTeams(List<Team> teams) => this.teams = teams;
}

class ParticipantModel {
  String code = '';
  String name = '';
  List<FormQuestion> form = [];
  List<FormQuestionResponse> responses = [];

  String get getCode => code;
  set setCode(String code) => this.code = code;

  String get getName => name;
  set setName(String name) => this.name = name;

  List<FormQuestion> get getForm => form;
  set setForm(List<FormQuestion> form) => this.form = form;

  List<FormQuestionResponse> get getResponses => responses;
  set setResponses(List<FormQuestionResponse> responses) => this.responses = responses;
}

class FormQuestion {
  final String id;
  final String question;
  final Map<int, String> options;

  FormQuestion({
    required this.id,
    required this.question,
    required this.options
  });
}

class FormQuestionResponse {
  final String formQuestionId;
  int formQuestionResponse;

  FormQuestionResponse({
    required this.formQuestionId,
    required this.formQuestionResponse,
  });
}

class Team {
  final int number;
  final List<String> memberIds;
  final List<String> memberNames;

  Team({
    required this.number,
    required this.memberIds,
    required this.memberNames,
  });
}