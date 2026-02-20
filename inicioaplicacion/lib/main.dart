import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAKekTeEJZXrAWAX5_kWyXU2kCRsYoQiYk",
      appId: "1:653843378802:web:26817c0ff36bccc54708eb",
      messagingSenderId: "653843378802",
      projectId: "buzonrh-geoponica",
      authDomain: "buzonrh-geoponica.firebaseapp.com",
      storageBucket: "buzonrh-geoponica.firebasestorage.app",
      measurementId: "G-J234SJ9Z16",
    ),
  );

  if (kIsWeb) {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
      sslEnabled: true,
    );
  }

  runApp(const BuzonApp());
}

class BuzonApp extends StatelessWidget {
  const BuzonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buzón RH',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}