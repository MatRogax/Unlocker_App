import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class SearchFieldWidget extends StatelessWidget {
  final Size size;
  final Widget child;

  const SearchFieldWidget({super.key, required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.06,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Constants.purpleTabBar.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: child,
    );
  }
}
