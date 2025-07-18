import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/search/pages/search_page.dart';
import 'package:projeto_unloucker/app/modules/eccomerce/shop/pages/shop_page.dart';
import 'package:projeto_unloucker/app/modules/profile/pages/profile_page.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  final List<Map<String, dynamic>> pages = [
    {"title": "GameUnloucker", "page": const ShopPage()},
    {"title": "Pesquisa", "page": const SearchPage()},
    {"title": "perfil", "page": const ProfilePage()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        backgroundColor: Constants.primaryMedium,
        currentIndex: currentIndex,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.manage_search_sharp), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
