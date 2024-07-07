import 'package:DermaVisuals/Controller/signup_controller.dart';
import 'package:DermaVisuals/Doctors/Doctor.dart';
import 'package:DermaVisuals/Doctors/DoctorVerificationForm.dart';
import 'package:DermaVisuals/Doctors/Prescription.dart';
import 'package:DermaVisuals/Users/Pharmacy/home.dart';
import 'package:DermaVisuals/Users/Pharmacy/home_page.dart';
import 'package:DermaVisuals/Users/SkinType%20Quiz.dart';
import 'package:DermaVisuals/Users/User.dart';
import 'package:DermaVisuals/Users/View%20Prescription.dart';
import 'package:DermaVisuals/constants/color%20constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar appbar(BuildContext context){
  return AppBar(
    backgroundColor: primaryAppColor,
    title: Image.asset("assets/DermaVisuals_logo.png", width: 200,),

  );
}

Drawer drawerDoctor(BuildContext context, String AccountType){
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

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:  (context) => DoctorHome()));
              },
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
            ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:  (context) => DoctorVerificationForm()));
            },
            child: ListTile(
              leading: Icon(Icons.verified_user),
              title: Text("Doctor Verification"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:  (context) => Prescription()));
            },
            child: ListTile(
              leading: Icon(Icons.edit),
              title: Text("Prescribe Patients"),
            ),
          ),
        ],
      ),
    );
}

Drawer drawerUser(BuildContext context, String AccountType){
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
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:  (context) => UserHome()));
                },
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:  (context) => SkinTypeQuizPage()));
                },
                child: ListTile(
                  leading: Icon(Icons.note_alt_outlined),
                  title: Text("Analyze your skin type"),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:  (context) => HomePage()));
                },
                child: ListTile(
                  leading: Icon(Icons.medication),
                  title: Text("Pharmacy"),
                ),
              ),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:  (context) => FetchPrescription()));
          },
          child: ListTile(
            leading: Icon(Icons.medical_services),
            title: Text("View Precription"),
          ),
        ),
      ],
    ),
  );
}