import 'package:flutter/material.dart';

class WigetFormField extends StatelessWidget {
  final Widget child;
  const WigetFormField({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.07,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.withValues(alpha: 0.3))),
      padding: EdgeInsets.only(left: size.width * 0.025, right: size.width * 0.025),
      child: child,
    );
  }
}
