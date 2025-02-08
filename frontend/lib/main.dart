import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:huddleup/firebase_options.dart';
import 'package:huddleup/providers/app_provider.dart';
import 'package:provider/provider.dart';

import 'package:huddleup/screens/home.dart';
import 'package:huddleup/screens/organizer/prompt.dart';
import 'package:huddleup/screens/organizer/waiting.dart';
import 'package:huddleup/screens/organizer/teams.dart';
import 'package:huddleup/screens/participant/code.dart';
import 'package:huddleup/screens/participant/name.dart';
import 'package:huddleup/screens/participant/form.dart';
import 'package:huddleup/screens/participant/wait.dart';
import 'package:huddleup/screens/participant/team.dart';
 
// function to trigger build when the app is run
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider (
      create: (context) => AppProvider(),
      child: const HuddleUpApp(),
    ),
  );
}

class HuddleUpApp extends StatelessWidget {
  const HuddleUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HuddleUp",
      // theme: ThemeData(colorScheme: )
      initialRoute: '/home',
      routes: {
        // home route
        '/home': (context) => const HomeRoute(),

        // organizer routes
        '/organizer/prompt': (context) => const OrganizerPromptRoute(),
        '/organizer/waiting':(context) => const OrganizerWaitingRoute(),
        '/organizer/teams':  (context) => const OrganizerTeamsRoute(),

        // participant routes
        '/participant/code': (context) => const ParticipantCodeRoute(),
        '/participant/name': (context) => const ParticipantNameRoute(),
        '/participant/form': (context) => const ParticipantFormRoute(),
        '/participant/wait': (context) => const ParticipantWaitRoute(),
        '/participant/team': (context) => const ParticipantTeamRoute(),
      },
    );
  }
}