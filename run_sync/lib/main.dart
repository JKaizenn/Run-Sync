import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:run_sync/firebase_options.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Run Sync',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme(
          primary: Colors.black,
          secondary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Set HomeScreen as the default screen
    );
  }
}