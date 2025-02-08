import 'package:flutter/material.dart';

class ParticipantTeamRoute extends StatelessWidget {
  const ParticipantTeamRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Huddle Up!"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("##"),
            const SizedBox(height: 16.0),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16.0)
          ]
        ),
      ),
    );
  }
}