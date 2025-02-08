import 'package:flutter/material.dart';

class ParticipantWaitRoute extends StatelessWidget {
  const ParticipantWaitRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Participant Waiting"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Waiting on your peers!"),
          ],
        )
      ,),
    );
  }
}
