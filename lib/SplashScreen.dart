import 'package:DermaVisuals/Login/Login.dart';
import 'package:DermaVisuals/Login/Login_option_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:DermaVisuals/Users/User.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
        logo: Image.asset(
            "assets/Untitled design (4).png", height: 600, width: 350,),
        logoWidth: 200,
      backgroundColor: Color(0xFFA86A44),
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: LoginOption(),
      durationInSeconds: 6,
    );
  }
}
