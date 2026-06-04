import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/store_provider.dart';
import 'app.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("Firebase Connected Successfully");

  /**   final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: 'test@gmail.com',
    password: '123456',
  );*/

  runApp(
    ChangeNotifierProvider(
      create: (_) => StoreProvider(),
      child: const MyApp(),
    ),
  );
}
