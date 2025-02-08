import 'package:flutter/material.dart';
import 'package:huddleup/consts.dart';
import 'package:huddleup/providers/app_provider.dart';
import 'package:provider/provider.dart';

class ParticipantTeamRoute extends StatelessWidget {
  const ParticipantTeamRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    String participantId = appProvider.getUserId();
    List<Team> allTeams = appProvider.getOrganizerTeams();

    Team participantTeam = allTeams[0];
    for (Team team in allTeams) {
      List<String> teamMemberIds = team.memberIds;
      for (String memberId in teamMemberIds) {
        if (participantId == memberId) {
          participantTeam = team;
        }
      }
    }
    int teamNumber = participantTeam.number;
    List<String> memberNames = participantTeam.memberNames;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Huddle Up!"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(teamNumber.toString()),
            const SizedBox(height: 16.0),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              itemCount: memberNames.length,
              itemBuilder: (context, index) {
                String memberName = memberNames[index];
                return Text(memberName);
              }
            )
          ]
        ),
      ),
    );
  }
}