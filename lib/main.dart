import 'package:flutter/material.dart';

import 'routes.dart';
import 'screens/add_screen.dart';
import 'screens/button_gallery_screen.dart';
import 'screens/details_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buttons & Navigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      // Named routes: every screen can be opened with Navigator.pushNamed().
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.buttons: (context) => const ButtonGalleryScreen(),
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.details: (context) => const DetailsScreen(),
        AppRoutes.settings: (context) => const SettingsScreen(),
        AppRoutes.add: (context) => const AddScreen(),
      },
    );
  }
}
