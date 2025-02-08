import 'package:flutter/material.dart';

class ParticipantNameRoute extends StatelessWidget {
  const ParticipantNameRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Participant Name"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("What's your name?"),
            const SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'My name is...',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text("Onward!"),
              onPressed: () {
                Navigator.pushNamed(context, '/participant/form');
              },
            ),
          ],
        ),
      ),
    );
  }
}
