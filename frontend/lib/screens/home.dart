import 'package:flutter/material.dart';
import 'package:huddleup/providers/app_provider.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
      AppProvider appProvider = Provider.of<AppProvider>(context);

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
                appProvider.setUserToOrganizer();
                Navigator.pushNamed(context, '/organizer/prompt');
              },
            ),
            ElevatedButton(
              child: const Text('Participant'),
              onPressed: () {
                appProvider.setUserToParticipant();
                Navigator.pushNamed(context, '/participant/code');
              },
            ),
          ],
        ),
      ),
    );
  }
}