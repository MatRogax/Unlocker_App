import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WidgetAppbar extends StatefulWidget {
  final String title;
  final IconButton? icon;
  const WidgetAppbar({super.key, required this.title, this.icon});

  @override
  State<WidgetAppbar> createState() => _WidgetAppbarState();
}

class _WidgetAppbarState extends State<WidgetAppbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Modular.to.pop()),
        title: Text(widget.title),
        centerTitle: true,
        actions: [widget.icon!],
      ),
    );
  }
}
