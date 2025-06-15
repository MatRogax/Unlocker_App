import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // <<< Adicione este import para fontes personalizadas
import 'package:projeto_unloucker/app/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[Constants.primaryDark, Constants.primaryMedium], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 220, 
                width: double.infinity,
                decoration: BoxDecoration(image: DecorationImage(image: const AssetImage("assets/images/eldenring3.png"), fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Constants.primaryDark.withValues(alpha: 0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.5, 1.0], 
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -80), 
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundColor: Constants.primaryDark, 
                            child: const CircleAvatar(radius: 38, backgroundImage: AssetImage("assets/images/eldenring3.png")),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('uuupi91', style: GoogleFonts.poppins(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                              Text('Team Liquid', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Bio', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text(
                        "I'm 35 years old, live in my parents basement and love to play games. I have no girlfriend and no money...",
                        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 20),
                      _buildFollowersSection(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(children: [_buildTabsSection(), const SizedBox(height: 20), _buildContentGrid()]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFollowersSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text('24', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text('Followers', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
            ],
          ),
          Column(
            children: [
              Text('127', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text('Following', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabsSection() {
    return Row(
      children: [_buildTab(index: 0, text: 'Posts'), const SizedBox(width: 10), _buildTab(index: 1, text: 'Reactions', icon: Icons.collections_bookmark)],
    );
  }

  Widget _buildTab({required int index, required String text, IconData? icon}) {
    final bool isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration:
              isSelected
                  ? BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF573AEA), Color(0xFF7A57EA)]), borderRadius: BorderRadius.circular(10))
                  : BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon, color: Colors.white70, size: 16),
              if (icon != null) const SizedBox(width: 8),
              Text(text, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6, 
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.8),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/images/eldenring.jpg", 
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
