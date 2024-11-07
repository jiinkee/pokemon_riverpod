import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_riverpod/core/locator.dart';
import 'package:pokemon_riverpod/home_screen.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await setUpLocator();
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stackTrace) async {
    debugPrintStack(stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        scaffoldBackgroundColor: Colors.lightGreen[50],
        useMaterial3: true,
        textTheme: GoogleFonts.quattrocentoSansTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightGreen[200],
        )
      ),
      home: const HomeScreen(),
    );
  }
}