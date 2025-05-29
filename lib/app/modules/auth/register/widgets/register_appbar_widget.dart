import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(gradient: LinearGradient(colors: <Color>[Constants.primaryDark, Constants.primaryMedium])),
      width: size.width,
      height: size.height * 0.4,
      child: SizedBox(
        height: size.height * 0.2,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(size.height * 0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Você já tem uma conta?", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.03),
                    child: SizedBox(
                      width: size.width * 0.26,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.button,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: const Text("Sign In", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
