import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/cubit/product_controller.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/product/services/model/product_model.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/shop/widgets/shop_card_category_widget.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/shop/widgets/shop_categorylist_widget.dart';
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
  late List<ProductModel> productsModel;
  ProductController controller = Modular.get<ProductController>();

  List<String> imagesPrincipalCarrousel = [
    "assets/images/eldenring3.png",
    "assets/images/ghost-capa.webp",
    "assets/images/eldenring.jpg",
    "assets/images/tlu.jpeg",
    "assets/images/eldenring2.webp",
    "assets/images/sekiro.jpg",
    "assets/images/narutostorm4.jpg",
  ];

  List<Map<String, dynamic>> categories = [
    {"title": "Mais Vendidos"},
    {"title": "Promoção"},
    {"title": "Console"},
    {"title": "Pc"},
  ];

  List<Map<String, dynamic>> products = [
    {"title": "Elden Ring Nightreign", "discount": 50, "price": 120.0, "image": "assets/images/eldenring.jpg", "timeLeft": "1h 25m"},
    {"title": "Elden Ring", "discount": 30, "price": 80.0, "image": "assets/images/eldenring2.webp", "timeLeft": "2h 15m"},
    {"title": "Elden Ring Shadow of the Erdtree", "discount": 40, "price": 100.0, "image": "assets/images/eldenring3.png", "timeLeft": "4h 5m"},
    {"title": "Naruto Ultimate Ninja Storm 4", "discount": 60, "price": 150.0, "image": "assets/images/narutocard.jpg", "timeLeft": "3h 20m"},
  ];

  Future<void> initModule() async {
    await controller.fetchDiscoverProducts();
  }

  @override
  void initState() {
    super.initState();
    initModule();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                                      : BoxDecoration(
                                        color: const Color.fromARGB(255, 22, 1, 35).withValues(alpha: 0.8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                BlocBuilder<ProductController, ProductState>(
                  bloc: controller,
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 40.0), child: CircularProgressIndicator()));
                    }

                    if (state is ProductsLoadSuccess) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.width * 0.05),
                            child: CustomCarousel(images: imagesPrincipalCarrousel, maxHeight: size.height * 0.25, itemWidth: size.width * 0.9),
                          ),
                          Padding(
                            padding: EdgeInsets.all(size.width * 0.02),
                            child: ProductListWidget(title: "Mais Vendidos", products: state.products, size: size),
                          ),
                          Padding(
                            padding: EdgeInsets.all(size.width * 0.04),
                            child: ProductListWidget(title: "Promoção", products: state.products, size: size),
                          ),
                        ],
                      );
                    }

                    if (state is ProductFailure) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Erro ao carregar conteúdo: ${state.error}', style: const TextStyle(color: Colors.red)),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
