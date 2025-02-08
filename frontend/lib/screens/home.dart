import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HUDDLEUP'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Organizer'),
              onPressed: () {
                Navigator.pushNamed(context, '/organizer/prompt');
              },
            ),
            ElevatedButton(
              child: const Text('Participant'),
              onPressed: () {
                Navigator.pushNamed(context, '/participant/code');
              },
            ),
          ],
        ),
      ),
    );
  }
}