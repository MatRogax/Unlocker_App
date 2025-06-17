import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabSectionWidget extends StatefulWidget {
  const TabSectionWidget({super.key});

  @override
  State<TabSectionWidget> createState() => _TabSectionWidgetState();
}

class _TabSectionWidgetState extends State<TabSectionWidget> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = 0;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration:
                      _selectedTabIndex == 0
                          ? BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF573AEA), Color(0xFF7A57EA)]),
                            borderRadius: BorderRadius.circular(10),
                          )
                          : BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.games, color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text('Galeria', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration:
                      _selectedTabIndex == 1
                          ? BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF573AEA), Color(0xFF7A57EA)]),
                            borderRadius: BorderRadius.circular(10),
                          )
                          : BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.white70, size: 16),
                      const SizedBox(width: 8),
                      Text('Favoritos', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
