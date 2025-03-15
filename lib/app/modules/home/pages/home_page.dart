import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_unloucker/app/modules/home/widgets/home_appbar_widget.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';
import 'package:projeto_unloucker/app/widgets/app_carrousel_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imagesPrincipalCarrousel = [
    "assets/images/crash.jpg",
    "assets/images/10bests.jpg",
    "assets/images/mario.webp",
    "assets/images/fifa.jpg",
    "assets/images/games_streaming.webp",
  ];
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
                height: size.height * 0.67,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  width: double.infinity,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(color: Constants.button, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
                  child: SizedBox(
                    height: size.height * 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CustomCarousel(images: imagesPrincipalCarrousel, maxHeight: size.height * 0.4, itemWidth: size.width * 1),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.04),
                            child: Text(
                              "Desbloqueie agora e comece a jogar!",
                              style: GoogleFonts.roboto(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.04),
                            child: SizedBox(
                              width: size.width * 0.75,
                              height: size.height * 0.07,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constants.primaryDark,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () => Navigator.pushNamed(context, '/register'),
                                child: Text("Comece agora !", style: GoogleFonts.alegreyaSans(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
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
