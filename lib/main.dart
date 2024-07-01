import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/screens.dart';
import 'widgets/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'podAI',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.purple[50],
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),
      home: NavBar(
        pages: const [
          HomeScreen(),
          CreateScreen(),
          ProfileScreen(),
        ],
      ),
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/podcast', page: () => const PodcastScreen()),
        //GetPage(name: '/settings', page: ()) => const SettingsScreen()),
      ],
    );
  }
}