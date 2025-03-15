import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/search/widgets/search_card_widget.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/search/widgets/search_field_widget.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController(text: "");
  List<Map<String, dynamic>> products = [
    {"title": "Elden Ring Nightreign", "discount": 50, "price": 120.0, "image": "assets/images/eldenring.jpg", "timeLeft": "1h 25m"},
    {"title": "Elden Ring", "discount": 30, "price": 80.0, "image": "assets/images/eldenring2.webp", "timeLeft": "2h 15m"},
    {"title": "Elden Ring Shadow of the Erdtree", "discount": 40, "price": 100.0, "image": "assets/images/eldenring3.png", "timeLeft": "4h 5m"},
    {"title": "Naruto Ultimate Ninja Storm 4", "discount": 60, "price": 150.0, "image": "assets/images/narutocard.jpg", "timeLeft": "3h 20m"},
    {"title": "Elden Ring Nightreign", "discount": 50, "price": 120.0, "image": "assets/images/eldenring.jpg", "timeLeft": "1h 25m"},
    {"title": "Elden Ring", "discount": 30, "price": 80.0, "image": "assets/images/eldenring2.webp", "timeLeft": "2h 15m"},
    {"title": "Elden Ring Shadow of the Erdtree", "discount": 40, "price": 100.0, "image": "assets/images/eldenring3.png", "timeLeft": "4h 5m"},
    {"title": "Naruto Ultimate Ninja Storm 4", "discount": 60, "price": 150.0, "image": "assets/images/narutocard.jpg", "timeLeft": "3h 20m"},
  ];

  @override
  void dispose() {
    searchController.dispose();
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SearchFieldWidget(
                      size: size,
                      child: TextFormField(
                        controller: searchController,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Pesquisar...',
                          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                          suffixIcon:
                              searchController.text.isNotEmpty
                                  ? IconButton(
                                    icon: const Icon(Icons.clear, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        searchController.clear();
                                      });
                                    },
                                  )
                                  : null,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SearchCardWidget(products: products, size: size),
            ],
          ),
        ),
      ),
    );
  }
}
