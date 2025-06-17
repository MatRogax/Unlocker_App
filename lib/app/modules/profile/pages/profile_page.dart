import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_unloucker/app/modules/auth/services/cubit/auth_controller.dart';
import 'package:projeto_unloucker/app/modules/profile/services/cubit/profile_controller.dart';
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
  final _profileController = Modular.get<ProfileController>();
  final _authController = Modular.get<AuthController>();
  String subTitleUser = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    final authState = _authController.state;
    if (authState is Authenticated) {
      _profileController.fetchUserProfile(authState.user.uid);
      initModule();
    }
  }

  void initModule() {
    subTitleUser = Utils.generateSubTitleUser();
  }

  @override
  void dispose() {
    Modular.dispose<ProfileController>();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProfileController, ProfileState>(
      bloc: _profileController,
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: DrawerprofileWidget(profileState: state),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: <Color>[Constants.primaryDark, Constants.primaryMedium], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is ProfileLoading || state is ProfileInitial)
                    const Center(child: Padding(padding: EdgeInsets.all(50.0), child: CircularProgressIndicator()))
                  else if (state is ProfileFailure)
                    Center(child: Text(state.error, style: const TextStyle(color: Colors.red)))
                  else if (state is ProfileLoadSuccess)
                    Column(
                      children: [
                        Container(
                          height: 220,
                          width: double.infinity,
                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/eldenring3.png"), fit: BoxFit.cover)),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.transparent, Constants.primaryDark.withAlpha(204)],
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
                                      child: CircleAvatar(
                                        radius: 38,
                                        backgroundImage:
                                            state.profile.profileImageUrl != null
                                                ? NetworkImage(state.profile.profileImageUrl!)
                                                : const AssetImage("assets/images/eldenring3.png") as ImageProvider,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.profile.username ?? state.profile.email,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          Text(subTitleUser, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                if (state.profile.bio != null && state.profile.bio!.isNotEmpty) ...[
                                  Text('Bio', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 5),
                                  Text(state.profile.bio!, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13, height: 1.4)),
                                ],
                                const SizedBox(height: 40),
                                FilterSectionWidget(),
                                const SizedBox(height: 40),
                                Column(children: [TabSectionWidget(), const SizedBox(height: 20), GridSectionProfile()]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
