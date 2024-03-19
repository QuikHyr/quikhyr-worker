import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr_worker/features/auth/data/repository/firebase_user_repo.dart';
import 'package:quikhyr_worker/firebase_options.dart';
import 'package:quikhyr_worker/my_app.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(firebaseUserRepo: FirebaseUserRepo(),));
}

