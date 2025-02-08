import 'package:flutter/material.dart';
import 'package:huddleup/providers/prompt_provider.dart';
import 'package:provider/provider.dart';

class OrganizerWaitingRoute extends StatelessWidget {
  const OrganizerWaitingRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
    PromptProvider promptProvider = Provider.of<PromptProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizer Waiting"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: [
            Text(promptProvider.prompt),
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
