import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huddleup/providers/prompt_provider.dart';
import 'package:provider/provider.dart';

class OrganizerPromptRoute extends StatelessWidget {
  const OrganizerPromptRoute({super.key});

  @override
  Widget build(BuildContext context) {
    PromptProvider promptProvider = Provider.of<PromptProvider>(context);

    return GestureDetector(
      // dismisses keyboards upon losing focus
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Organizer Prompt"),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Describe what type of teams that you trying to form?'
                ),
                SizedBox(
                  height: 5 * 24.0,
                  child: TextField(
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'I am trying to form teams of...',
                    ),
                    onChanged: (text) {
                      promptProvider.setPrompt(text);
                      print('prompt: $text (${text.characters.length})');
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    // const SizedBox(width: 8.0),
                    SizedBox(
                      width: 100.0,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "2-100",
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          // restricts user input to integers from 2 to 100 inclusive
                          FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}$')), // only allow max of 3 digits
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            final text = newValue.text;
                            if (text.isNotEmpty) {
                              final value = int.tryParse(text);
                              if (value == null || value < 2 || value > 100) {
                                return oldValue; // reject invalid input
                              }
                            }
                            promptProvider.setTeamSize(int.parse(text));
                            return newValue; // allow valid input
                          }),
                        ],
                      ),
                    ),
                    const Text(
                      ' people per team.',
                      style: TextStyle(
                        fontSize: 18.0,
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    ElevatedButton(
                      child: const Text('Back!'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Start Forming!'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/organizer/waiting');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
