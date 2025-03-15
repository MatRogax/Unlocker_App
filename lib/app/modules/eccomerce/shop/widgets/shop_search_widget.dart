import 'package:flutter/material.dart';

class ShopSearchWidget extends StatefulWidget {
  final Size size;
  const ShopSearchWidget({super.key, required this.size});

  @override
  State<ShopSearchWidget> createState() => _ShopSearchWidgetState();
}

class _ShopSearchWidgetState extends State<ShopSearchWidget> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size sizeWidget = widget.size;
    return Container(
      height: sizeWidget.height * 0.065,
      width: sizeWidget.width * 0.8,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
          hintText: 'Pesquisar...',
          contentPadding: EdgeInsets.symmetric(horizontal: sizeWidget.width * 0.04, vertical: sizeWidget.height * 0.02),
          hintStyle: TextStyle(fontSize: sizeWidget.width * 0.045, color: Colors.grey),
        ),
      ),
    );
  }
}
