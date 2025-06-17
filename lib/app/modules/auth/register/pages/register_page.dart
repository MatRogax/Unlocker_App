import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_unloucker/app/modules/auth/register/widgets/register_appbar_widget.dart';
import 'package:projeto_unloucker/app/modules/auth/register/widgets/register_auth_widget.dart';
import 'package:projeto_unloucker/app/modules/auth/services/cubit/auth_controller.dart';
import 'package:projeto_unloucker/app/modules/auth/services/repository/auth_repository.dart';
import 'package:projeto_unloucker/app/modules/profile/services/repository/profile_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthController(authRepository: AuthRepository(profileRepository: ProfileRepository())),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            width: double.infinity,
            height: size.height,
            child: Stack(
              children: [
                const Appbar(),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    width: double.infinity,
                    height: size.height * 0.75,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text("Crie Sua Conta", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "desbloqueie as melhores ofertas de jogos",
                              style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const WidgetRegisterForm(),
                        ],
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
