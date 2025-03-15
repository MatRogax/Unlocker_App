import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: <Color>[Constants.primaryDark, Constants.primaryMedium])),
        width: size.width,
        height: size.height * 0.4,
        child: SizedBox(
          height: size.height * 0.2,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.04, bottom: size.height * 0.015),
                child: Text("Game Unlocker", style: TextStyle(fontSize: size.height * 0.042, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              SizedBox(width: size.width * 0.8, height: size.height * 0.16, child: Container(child: Image.asset('assets/images/logo.png'))),
            ],
          ),
        ),
      ),
    );
  }
}
