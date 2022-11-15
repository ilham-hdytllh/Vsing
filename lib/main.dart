import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vsing/auth/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vsing/pages/barcode_screen.dart';
import 'package:vsing/pages/verifi_screen.dart';
import 'firebase_options.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('id_ID', null).then;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainPage(),
    );
  }
}
