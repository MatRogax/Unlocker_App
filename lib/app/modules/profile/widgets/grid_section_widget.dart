import 'package:flutter/material.dart';

class GridSectionProfile extends StatelessWidget {
  final int? itemCountView;
  const GridSectionProfile({super.key, this.itemCountView});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.8),
      itemBuilder: (context, index) {
        return ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset("assets/images/eldenring.jpg", fit: BoxFit.cover));
      },
    );
  }
}
