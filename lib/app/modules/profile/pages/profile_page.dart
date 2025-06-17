import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_unloucker/app/modules/profile/widgets/drawer_widget.dart';
import 'package:projeto_unloucker/app/modules/profile/widgets/filter_section_widget.dart';
import 'package:projeto_unloucker/app/modules/profile/widgets/grid_section_widget.dart';
import 'package:projeto_unloucker/app/modules/profile/widgets/tab_section_widget.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';
import 'package:projeto_unloucker/app/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedTabIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final User? user = FirebaseAuth.instance.currentUser;
  late String subTitleUser;
  String bio = "";

  @override
  void initState() {
    super.initState();
    initModule();
  }

  void initModule() {
    subTitleUser = Utils.generateSubTitleUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerprofileWidget(),
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
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Constants.primaryDark.withValues(alpha: 0.8)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.035, left: size.width * 0.04, right: size.width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                            icon: const Icon(Icons.menu),
                            color: Colors.white,
                            iconSize: size.width * 0.07,
                            tooltip: "Menu",
                          ),
                        ],
                      ),
                    ),
                  ],
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

                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user!.email!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Text(subTitleUser, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (bio.isNotEmpty) ...{
                        Text('Bio', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Text(bio, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13, height: 1.4)),
                      },
                      const SizedBox(height: 20),
                      FilterSectionWidget(),
                      const SizedBox(height: 40),
                      Column(children: [TabSectionWidget(), const SizedBox(height: 20), GridSectionProfile()]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
