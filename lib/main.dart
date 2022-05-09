import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nimblerx_app/presentation/screens/home_screen.dart';
import 'package:nimblerx_app/utils/constants.dart';
import 'package:nimblerx_app/utils/extensions.dart';

void main() {
  runApp(const ProviderScope(child: NimbleRxApp()));
}

class NimbleRxApp extends StatelessWidget {
  const NimbleRxApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: nimbleTeal.toMaterialColor(),
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}
