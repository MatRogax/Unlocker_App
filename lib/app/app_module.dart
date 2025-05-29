import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_unloucker/app/modules/auth/login/pages/login_page.dart';
import 'package:projeto_unloucker/app/modules/auth/register/pages/register_page.dart';
import 'package:projeto_unloucker/app/modules/auth/services/cubit/auth_cubit.dart';
import 'package:projeto_unloucker/app/modules/auth/services/repository/auth_repository.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/navigation/pages/navigation_page.dart';

// class AppNavigator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => const RegisterPage());
//       case '/login':
//         return MaterialPageRoute(builder: (_) => const LoginPage());
//       case '/shop':
//         return MaterialPageRoute(builder: (_) => const NavigationPage());
//       case '/search':
//       default:
//         return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Rota não Encontrada!'))));
//     }
//   }
// }

import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_unloucker/app/modules/auth/services/repository/auth_repository.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/navigation/pages/navigation_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AuthRepository>(AuthRepository.new);
    i.add<AuthCubit>(() => AuthCubit(authRepository: i.get()));
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const RegisterPage());

    r.child('/login', child: (_) => const LoginPage());

    r.child('/shop', child: (_) => const NavigationPage());

    r.child('/notfound', child: (_) => const Scaffold(body: Center(child: Text('Rota não encontrada!'))));
  }
}
