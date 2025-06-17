import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_unloucker/app/modules/auth/login/widgets/login_appbar_widget.dart';
import 'package:projeto_unloucker/app/modules/auth/login/widgets/login_auth_widget.dart';
import 'package:projeto_unloucker/app/modules/auth/services/cubit/auth_controller.dart';
import 'package:projeto_unloucker/app/modules/auth/services/repository/auth_repository.dart';
import 'package:projeto_unloucker/app/modules/profile/services/repository/profile_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthController(authRepository: AuthRepository(profileRepository: ProfileRepository())),
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: size.height * 2,
            child: Stack(
              children: [
                const LoginAppbar(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: size.height * 0.71,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      width: double.infinity,
                      height: size.height * 0.5,
                      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          height: size.height * 0.65,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: size.height * 0.06),
                                    child: const Text("Entre com Suas Credenciais", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: size.height * 0.025, bottom: size.height * 0.02),
                                    child: const Text(
                                      "Pronto para desbloquear novos mundos?",
                                      style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: size.height * 0.02), child: const WidgetFormLogin()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
