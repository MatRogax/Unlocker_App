import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/modules/home/widgets/home_appbar_widget.dart';
import 'package:projeto_unloucker/app/modules/home/widgets/home_carousel_widget.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> frases = ["Explore novos jogos incríveis!", "Compre facilmente suas chaves de jogos.", "Desbloqueie mundos e comece a jogar agora!"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: size.height * 2,
        child: Stack(
          children: [
            const HomeAppbar(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: size.height * 0.65,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  width: double.infinity,
                  height: size.height * 0.2,
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                  child: SizedBox(
                    height: size.height * 1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CarouselWidget(images: [], size: size),
                          const Text("Desbloqueie agora e comece a jogar!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.035),
                            child: SizedBox(
                              width: size.width * 0.75,
                              height: size.height * 0.08,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.primaryMedium,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () => Navigator.pushNamed(context, '/register'),
                                child: const Text("Comece agora!", style: TextStyle(fontSize: 16, color: Colors.white)),
                              ),
                            ),
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
    );
  }
}
