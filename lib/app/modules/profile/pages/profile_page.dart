import 'package:flutter/material.dart';
import 'package:projeto_unloucker/app/widgets/widget_appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: WidgetAppbar(title: "", icon: IconButton(onPressed: () => null, icon: const Icon(Icons.menu))),
      ),
    );
  }
}
