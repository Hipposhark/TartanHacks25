import 'package:flutter/material.dart';
import 'package:huddleup/consts.dart';
import 'package:huddleup/providers/app_provider.dart';
import 'package:provider/provider.dart';

class ParticipantFormRoute extends StatelessWidget {
  const ParticipantFormRoute({super.key});
 
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    String userName = appProvider.getParticipantName();
    List<FormQuestion> userForm = appProvider.getParticipantForm();
    List<FormQuestionResponse> userResponses = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Participant Name"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Answer these Questions $userName!"),
            const SizedBox(height: 16.0),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              itemCount: userForm.length,
              itemBuilder: (context, index) {
                int questionNum = index + 1;
                FormQuestion formQuestion = userForm[index];
                String question = formQuestion.question;
                Map<int, String> options = formQuestion.options;
                int defaultSelectedOption = 1;
                
                return Column(
                  children: [
                    ListTile(
                      title: Text('$questionNum) $question'),
                    ),
                    ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        String option = options[index+1] ?? '';
                        return ListTile(
                          title: Text(option),
                          leading: Radio<int>(
                            value: index+1,
                            groupValue: defaultSelectedOption,
                            onChanged: (value) {
                              bool inUserResponses = false;
                              for (var i = 0; i < userResponses.length; i++) {
                                FormQuestionResponse currResponse = userResponses[i];
                                if (currResponse.formQuestionId == formQuestion.id) {
                                  inUserResponses = true;
                                  currResponse.formQuestionResponse = value ?? 1;
                                }
                              }
                              if (!inUserResponses) {
                                FormQuestionResponse formQuestionResponse = FormQuestionResponse(formQuestionId: formQuestion.id, formQuestionResponse: value ?? 1);
                                userResponses.add(formQuestionResponse);
                              }
                            },
                          ),
                        );
                      }
                    )
                  ]
                );
              },
            ),
          ]
        ),
      ),
    );
  }
}
