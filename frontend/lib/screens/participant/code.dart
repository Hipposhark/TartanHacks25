import 'package:flutter/material.dart';
import 'package:huddleup/providers/app_provider.dart';
import 'package:provider/provider.dart';

class ParticipantCodeRoute extends StatelessWidget {
  const ParticipantCodeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Participant Code"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("What's your Organizer Code?"),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'My code is...',
              ),
              onChanged: (newCode) => {
                appProvider.setParticipantCode(newCode)
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text("Onward!"),
              onPressed: () {
                Navigator.pushNamed(context, '/participant/name');
              },
            ),
          ],
        ),
      ),
    );
  }
}
