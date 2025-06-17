import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/model/product_model.dart';

class ProductListWidget extends StatelessWidget {
  final String title;
  final List<ProductModel> products;
  final Size size;

  const ProductListWidget({Key? key, required this.title, required this.products, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.57,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.015, bottom: size.height * 0.015),
                child: SizedBox(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.04),
                        child: Text(title, style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          Text("Veja Todos", style: GoogleFonts.roboto(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.only(left: size.width * 0.015), child: Icon(Icons.arrow_circle_right, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length % 2 == 0 ? products.length : products.length + 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: Card(
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
                              child: Image.network(products[index].backgroundImage!, fit: BoxFit.cover, width: double.infinity),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width * 0.02),
                                    child: Text(
                                      products[index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: size.width * 0.02),
                                        child: Text(
                                          "${products[index].id}", // "R\$ ${products[index].id.toStringAsFixed(2)}",
                                          style: GoogleFonts.roboto(color: Colors.greenAccent, fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: size.width * 0.02),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFF573AEA), Color(0xFF7A57EA)],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                            child: Text(
                                              "- 60%",
                                              style: GoogleFonts.roboto(color: Colors.white, fontSize: size.width * 0.03, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: size.width * 0.015),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.timer, color: Colors.white, size: 15),
                                        Padding(
                                          padding: EdgeInsets.only(left: size.width * 0.02),
                                          child: Text(
                                            // "Termina em: ${products[index].name}",
                                            "",
                                            style: GoogleFonts.roboto(color: Colors.white, fontSize: size.width * 0.03),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.add_shopping_cart_sharp, color: Colors.white, size: size.width * 0.07),
                                        Text("Comprar", style: GoogleFonts.roboto(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
