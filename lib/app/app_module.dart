import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/modules/auth/login/pages/login_page.dart';
import 'package:projeto_unloucker/app/modules/auth/register/pages/register_page.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/navigation/pages/navigation_page.dart';
import 'package:projeto_unloucker/app/modules/home/pages/home_page.dart';

class AppNavigator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/shop':
        return MaterialPageRoute(builder: (_) => const NavigationPage());
      case '/search':
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Rota não Encontrada!'))));
    }
  }
}
