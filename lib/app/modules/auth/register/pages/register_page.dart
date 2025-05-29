import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/modules/auth/register/widgets/register_appbar_widget.dart';
import 'package:projeto_unloucker/app/modules/auth/register/widgets/register_auth_widget.dart';
import 'package:projeto_unloucker/app/modules/auth/services/controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = RegisterController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: size.height * 2,
          child: Stack(
            children: [
              const Appbar(),
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
                        height: size.height * 0.7,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: size.height * 0.07),
                                  child: const Text("Crie Sua Conta", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: size.height * 0.015, bottom: size.height * 0.025),
                                  child: const Text(
                                    "desbloqueie as melhores ofertas de jogos",
                                    style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: size.height * 0.04), child: WidgetRegisterForm()),
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
    );
  }
}
