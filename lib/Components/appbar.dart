import 'package:DermaVisuals/Controller/signup_controller.dart';
import 'package:DermaVisuals/Users/SkinType%20Quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:DermaVisuals/Users/Questionnair.dart';

AppBar appbar(BuildContext context){
  return AppBar(
    backgroundColor: Color(0xFFA86A44),
    title: Image.asset("assets/DermaVisuals_logo.png", width: 200,),

  );
}

Drawer drawer(BuildContext context, String AccountType){
  String? accountEmail;
  if (FirebaseAuth.instance.currentUser != null) {
    if (FirebaseAuth.instance.currentUser?.email != null) {
      // User signed up with an email
      accountEmail = FirebaseAuth.instance.currentUser!.email;
    } else if (FirebaseAuth.instance.currentUser?.phoneNumber != null) {
      // User signed up with a mobile number
      accountEmail = FirebaseAuth.instance.currentUser!.phoneNumber;
    }
  } else {
    accountEmail = 'No Email';
  }
  final controller = Get.put(SignupController());
  return  Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(
                    0xFFA86A44), // Set the background color to brown
              ),
              accountName: Text(
                  '${FirebaseAuth.instance.currentUser?.displayName }'),
              accountEmail: Text('${accountEmail}')
            // currentAccountPicture: CircleAvatar(
            //   backgroundImage: AssetImage('assets/profile_image.jpg'),
            // ),
          ),
          InkWell(
            onTap: () {
              SignupController.instance.LogoutUser();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ),
          ),
          if(AccountType=="User")
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:  (context) => SkinTypeQuizPage()));
              },
              child: ListTile(
                leading: Icon(Icons.note_alt_outlined),
                title: Text("Analyze your skin type"),
              ),
            ),
        ],
      ),
    );
}