import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';
import 'package:shimmer/shimmer.dart';

class ShopLoadingWidget extends StatelessWidget {
  const ShopLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Constants.otherColor,
      highlightColor: Constants.button,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.width * 0.05),
              child: Center(
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.25,
                  decoration: BoxDecoration(color: Constants.otherColor, borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.width * 0.06, left: size.width * 0.05, bottom: size.width * 0.02),
              child: Container(width: size.width * 0.4, height: 24.0, color: Constants.otherColor),
            ),
            _buildProductListPlaceholder(size, Constants.otherColor),
            Padding(
              padding: EdgeInsets.only(top: size.width * 0.06, left: size.width * 0.05, bottom: size.width * 0.02),
              child: Container(width: size.width * 0.3, height: 24.0, color: Constants.otherColor),
            ),
            _buildProductListPlaceholder(size, Constants.otherColor),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListPlaceholder(Size size, Color color) {
    return SizedBox(
      height: size.height * 0.22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: size.width * 0.4,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10.0)),
          );
        },
      ),
    );
  }
}
