import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class LoginAppbar extends StatelessWidget {
  const LoginAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Constants.primaryDark, Constants.primaryMedium], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: <Color>[Constants.primaryDark, Constants.primaryMedium])),
        width: size.width,
        height: size.height * 0.4,
        child: SizedBox(
          // height: size.height * 0.2,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.04),
                child: const Text("Seja Bem vindo de Volta", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
