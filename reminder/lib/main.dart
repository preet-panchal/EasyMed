import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/view/google_sign_in.dart';
import 'package:reminder/view/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'EasyMed App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
      ));
}
