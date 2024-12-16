 import 'package:firebase_core/firebase_core.dart';
import 'package:trekkingmap/core/theme/theme.dart'; 
import 'package:trekkingmap/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trekkingmap/firebase_options.dart';
import 'package:trekkingmap/signup.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
 
  final container = ProviderContainer();
 
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     return MaterialApp(
      title: 'Music App',
      theme: AppTheme.darkThemeMode,
      // home: currentUser == null ? const SignupPage() : const HomePage(), //isn= //sn= commented out 
      home:  const SignupPage(),  
       
    );
  }
}


