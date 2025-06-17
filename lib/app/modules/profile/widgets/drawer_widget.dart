import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:projeto_unloucker/app/modules/auth/services/cubit/auth_controller.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';
import 'package:projeto_unloucker/app/utils/utils.dart';

class DrawerprofileWidget extends StatefulWidget {
  const DrawerprofileWidget({super.key});

  @override
  State<DrawerprofileWidget> createState() => _DrawerprofileWidgetState();
}

class _DrawerprofileWidgetState extends State<DrawerprofileWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.65,
      child: Drawer(
        backgroundColor: Constants.primaryDark,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 35, backgroundColor: Colors.white, child: Icon(Icons.person, size: 40, color: Colors.grey)),
                  SizedBox(height: 15),
                  Text("Jane Doe", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("jane.doe@example.com", style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person_pin, color: Colors.white70, size: 28),
              title: const Text('Meu Perfil', style: TextStyle(color: Colors.white, fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag_outlined, color: Colors.white70, size: 28),
              title: const Text('Meus Pedidos', style: TextStyle(color: Colors.white, fontSize: 18)),
              onTap: () {
                Modular.to.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: Colors.white70, size: 28),
              title: const Text('Configurações', style: TextStyle(color: Colors.white, fontSize: 18)),
              onTap: () {
                Modular.to.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_off, color: Colors.white70, size: 28),
              title: const Text('Excluir conta', style: TextStyle(color: Colors.white, fontSize: 18)),
              onTap: () {
                ;
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.white70, size: 28),
              title: const Text('Ajuda e Suporte', style: TextStyle(color: Colors.white, fontSize: 18)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF503873),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  await Modular.get<AuthController>().performSignOut();
                  Modular.to.navigate(Modular.initialRoute);
                  Utils.showInfo(context: context, message: "👋 Você foi desconectado. Até logo!");
                },

                child: const Text('Log Out', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
