import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/shop/widgets/shop_card_category_widget.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/shop/widgets/shop_card_product.dart';
// import 'package:projeto_unloucker/app/modules/eccomerce/shop/widgets/shop_products_category_widget.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';
import 'package:projeto_unloucker/app/widgets/app_carrousel_widget.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int selectedIndex = -1;

  List<String> imagesPrincipalCarrousel = [
    "assets/images/eldenring.png",
    "assets/images/eldenring.png",
    "assets/images/eldenring.png",
    "assets/images/eldenring.png",
  ];

  List<Map<String, dynamic>> categories = [
    {"title": "Mais Vendidos"},
    {"title": "Promoção"},
    {"title": "Console"},
    {"title": "Pc"},
  ];

  List<Map<String, dynamic>> products = [
    {"title": "ONE PUNCH MAN: A HERO NOBODY KNOWS - DELUXE", "discount": 50, "price": 120.0, "image": "assets/images/eldenring.png", "timeLeft": "1h 25m"},
    {"title": "Contra Anniversary Collection", "discount": 30, "price": 80.0, "image": "assets/images/eldenring.png", "timeLeft": "2h 15m"},
    {"title": "Castlevania Anniversary Collection", "discount": 40, "price": 100.0, "image": "assets/images/eldenring.png", "timeLeft": "4h 5m"},
    {"title": "DRAGON BALL FighterZ - FighterZ Edition", "discount": 60, "price": 150.0, "image": "assets/images/eldenring.png", "timeLeft": "3h 20m"},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[Constants.primaryDark, Constants.primaryMedium], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02, left: size.width * 0.05, right: size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "GameUnloucker",
                        style: GoogleFonts.roboto(textStyle: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(iconSize: size.width * 0.07, onPressed: () {}, icon: const Icon(Icons.shopping_bag, color: Colors.white)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: SizedBox(
                    height: size.height * 0.045,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = selectedIndex == index ? -1 : index;
                              });
                            },
                            child: ShopCategoryCard(
                              decoration:
                                  selectedIndex == index
                                      ? BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: <Color>[Color(0xFF573AEA), Color(0xFF7A57EA)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                      : BoxDecoration(color: const Color.fromARGB(255, 22, 1, 35).withOpacity(0.8), borderRadius: BorderRadius.circular(10)),
                              childCard: Center(
                                child: Text(
                                  categories[index]['title'],
                                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                              size: size,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width * 0.05),
                  child: CustomCarousel(images: imagesPrincipalCarrousel, maxHeight: size.height * 0.25, itemWidth: size.width * 0.9),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width * 0.04),
                  child: SizedBox(
                    height: size.height * 0.8,
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
                                      child: Text("Mais Vendidos", style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold)),
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
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizedBox(
                                  width: size.width * 0.45,
                                  child: Card(
                                    color: Colors.white,
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
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  products[index]["title"],
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: size.width * 0.01),
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
                                                            style: GoogleFonts.roboto(
                                                              color: Colors.white,
                                                              fontSize: size.width * 0.03,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: size.width * 0.02),
                                                      child: Text(
                                                        "R\$ ${products[index]["price"].toStringAsFixed(2)}",
                                                        style: GoogleFonts.roboto(
                                                          color: Colors.black,
                                                          fontSize: size.width * 0.03,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    const Icon(Icons.timer, color: Colors.grey, size: 15),
                                                    Text(
                                                      "Termina em: ${products[index]["timeLeft"]}",
                                                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                                                    ),
                                                  ],
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
                  ),
                  // child: GridView.builder(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 10,
                  //     mainAxisSpacing: 10,
                  //     childAspectRatio: 0.8,
                  //   ),
                  //   itemCount: products.length,
                  //   itemBuilder: (context, index) {
                  //     final product = products[index];
                  //     return Card(
                  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  //       elevation: 6,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Expanded(
                  //             child: ClipRRect(
                  //               borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  //               child: Image.asset(product["image"], fit: BoxFit.cover, width: double.infinity),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   product["title"],
                  //                   maxLines: 2,
                  //                   overflow: TextOverflow.ellipsis,
                  //                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  //                 ),
                  //                 const SizedBox(height: 4),
                  //                 Text("Desconto: ${product["discount"]}%", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  //                 const SizedBox(height: 4),
                  //                 Text("R\$ ${product["price"].toStringAsFixed(2)}", style: const TextStyle(fontSize: 14)),
                  //                 const SizedBox(height: 4),
                  //                 Text("Termina em: ${product["timeLeft"]}", style: const TextStyle(color: Colors.grey)),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
