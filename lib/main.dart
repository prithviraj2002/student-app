import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student/core/locator/locator.dart';
import 'package:student/core/pages/app_pages.dart';
import 'package:student/data/db/notif_service.dart';
import 'package:student/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.initial,
      routes: routes,
    );
  }
}
