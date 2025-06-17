import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_unloucker/app/modules/auth/login/pages/login_page.dart';
import 'package:projeto_unloucker/app/modules/auth/register/pages/register_page.dart';
import 'package:projeto_unloucker/app/modules/auth/services/cubit/auth_controller.dart';
import 'package:projeto_unloucker/app/modules/auth/services/repository/auth_repository.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/cubit/product_controller.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/repository/product-repository.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/navigation/pages/navigation_page.dart';
import 'package:projeto_unloucker/app/modules/profile/services/cubit/profile_controller.dart';
import 'package:projeto_unloucker/app/modules/profile/services/repository/profile_repository.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<AbstractProfileRepository>(ProfileRepository.new);
    i.addSingleton<AbstractProductRepository>(ProductRepository.new);
    i.addSingleton<AbstractAuthRepository>(() => AuthRepository(profileRepository: i.get()));

    i.addSingleton<AuthController>(() => AuthController(authRepository: i.get()));
    i.add<ProfileController>(() => ProfileController(profileRepository: i.get()));
    i.add<ProductController>(() => ProductController(productRepository: i.get()));
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => const RegisterPage());
    r.child('/login', child: (_) => const LoginPage());
    r.child('/shop', child: (_) => const NavigationPage());
    r.child('/notfound', child: (_) => const Scaffold(body: Center(child: Text('Rota não encontrada!'))));
  }
}
