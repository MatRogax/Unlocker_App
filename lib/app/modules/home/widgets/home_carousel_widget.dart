import 'dart:async';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  final Size size;
  final List<String> images;
  CarouselWidget({Key? key, required this.size, required this.images}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final PageController pageController = PageController();
  late Timer timer;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentPage < widget.images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      if (pageController.hasClients) {
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height * 0.25, // Ajuste conforme necessário
      child: PageView.builder(
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return Container(
            width: widget.size.width,
            height: widget.size.height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Ajuste se necessário
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Mantém a borda arredondada
              child: Image.asset(
                widget.images[index],
                width: widget.size.width,
                height: widget.size.height * 0.25,
                fit: BoxFit.cover, // Faz a imagem preencher o container sem distorcer
              ),
            ),
          );
        },
      ),
    );
  }
}
