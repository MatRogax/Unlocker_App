import 'package:flutter/material.dart';

class ShopCategoryCard extends StatelessWidget {
  final Size size;
  final Widget childCard;
  final Decoration decoration;
  const ShopCategoryCard({super.key, required this.childCard, required this.size, required this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(height: size.height * 0.022, width: size.width * 0.28, decoration: decoration, child: childCard);
  }
}
