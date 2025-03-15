import 'package:flutter/material.dart';

class SearchCardWidget extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Size size;
  const SearchCardWidget({super.key, required this.products, required this.size});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(size.width * 0.08),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: Image.asset(products[index]["image"], fit: BoxFit.cover, width: double.infinity),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
