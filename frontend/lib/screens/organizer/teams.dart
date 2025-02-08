import 'package:flutter/material.dart';

class OrganizerTeamsRoute extends StatelessWidget {
  const OrganizerTeamsRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organized Teams"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text("Teams"),
            const SizedBox(height: 16.0),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text("[code]"),
          ],
        ),
      ),
    );
  }
}