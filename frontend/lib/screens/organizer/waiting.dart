import 'package:flutter/material.dart';
import 'package:huddleup/providers/app_provider.dart';
import 'package:provider/provider.dart';

class OrganizerWaitingRoute extends StatelessWidget {
  const OrganizerWaitingRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizer Waiting"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Text(appProvider.getOrganizerPrompt()),
            // Text("[prompt]"),
            Text("[code]"),
            ElevatedButton(
              child: const Text('Finalize Teams!'),
              onPressed: () {
                Navigator.pushNamed(context, '/organizer/teams');
              },
            ),
          ],
        )
      ,),
    );
  }
}
