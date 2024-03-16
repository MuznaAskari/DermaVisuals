import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DermaVisuals/Controller/signup_controller.dart';
import 'package:DermaVisuals/Controller/Otp_controller.dart';
import 'package:DermaVisuals/Login/Login.dart';
import 'package:DermaVisuals/Login/OTP_Screen.dart';
import 'package:DermaVisuals/authentication/authetication_repository.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_option_page.dart';

class Signup_phone extends StatefulWidget {
  const Signup_phone({Key? key}) : super(key: key);

  @override
  State<Signup_phone> createState() => _Signup_phoneState();
}

class _Signup_phoneState extends State<Signup_phone> {
  final controller = Get.put(SignupController());
  final _SignupformKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  Set<String> options = {"User", "Doctor"};
  String currentItemSelected = selectedTabName;
  String role = selectedTabName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
          child:
              Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/login-background.png"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  height: 600,
                  width: 350,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.brown[50],

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _SignupformKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/OTP.gif'),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: controller.phoneNo,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: '+92 ----------',
                              icon: Icon(Icons.phone),
                            ),
                          ),
                          TextFormField(
                            controller: controller.fullName,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                            ),
                          ),

                          // drop down list to select the portal type
                          SizedBox(height: 15, width: 10,),
                          Container(
                            width: 200,
                            child: DropdownButton<String>(
                              dropdownColor: Colors.brown[50],
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: Color(0xFFA86A44),
                              focusColor: Color(0xFFA86A44),
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: GoogleFonts.alkatra(
                                      color: Color(0xFFA86A44),
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  currentItemSelected = newValueSelected!;
                                  role = newValueSelected;
                                });
                              },
                              value: currentItemSelected,
                            ),
                          ),
                          SizedBox(height: 100, width: 100,),

                          InkWell(
                            onTap: () {
                              if (_SignupformKey.currentState != null && _SignupformKey.currentState!.validate()){
                                SignupController.instance.phoneAuthentication(controller.phoneNo.text.trim(), controller.fullName.text.trim(), role);
                                Get.to(() => const OTP_Screen());
                              }
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'SIGN UP with Phone No.',
                                  style: GoogleFonts.alkatra(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow[50]
                                  ),

                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.brown[700]!,
                                    Color(0xFFA86A44),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),

    );
  }
}