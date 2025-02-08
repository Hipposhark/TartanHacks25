import 'package:flutter/material.dart';

class ParticipantFormRoute extends StatelessWidget {
  const ParticipantFormRoute({super.key});
 
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
            const Text("Answer these Questions!"),
            const SizedBox(height: 16.0),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // ListView.builder(
            //   itemCount: 10,
            //   itemBuilder: (context, index) {
            //   return ListTile(
            //     title: Text("q#"),
            //   );
            //   },
            // ),
          ]
        ),
      ),
    );
  }
}
