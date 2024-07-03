import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podai/screens/screens.dart';
import 'package:podai/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Other properties remain unchanged
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return LoginScreen(); // Or your login screen
            }
            return NavBar(pages: const [HomeScreen(), CreateScreen(), ProfileScreen()]);
          }
          return CircularProgressIndicator(); // Loading state
        },
      ),
      
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/podcast', page: () => const PodcastScreen()),
        //GetPage(name: '/settings', page: ()) => const SettingsScreen()),
      ],
    );
  }
}