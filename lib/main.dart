import 'package:flutter/material.dart';
import 'package:places/ui/screens/login_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Places",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      // MIENTRAS NO SE INSTALE router, la app arrancará aquí:
      home: const LoginScreen(), 
    );
  }
}
