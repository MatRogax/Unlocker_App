import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/app_module.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppNavigator.generateRoute,
      initialRoute: '/',
    );
  }
}
