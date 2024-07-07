import 'package:flutter/material.dart';
import 'package:podai/screens/register_screen.dart';
import 'package:podai/screens/screens.dart';
import 'package:podai/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return RegisterScreen(); // Or your login screen
            }
            return NavBar(pages: const [HomeScreen(), CreateScreen(), ProfileScreen()]);
          }
          return CircularProgressIndicator(); // Loading state
        },
      ),
      
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/podcast': (context) => const PodcastScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}