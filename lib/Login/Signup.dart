import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DermaVisuals/Controller/signup_controller.dart';
import 'package:DermaVisuals/Controller/Otp_controller.dart';
import 'package:DermaVisuals/Login/Login.dart';
import 'package:DermaVisuals/Login/OTP_Screen.dart';
import 'package:DermaVisuals/ToastMessage/Utilis.dart';
import 'package:DermaVisuals/authentication/authetication_repository.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login_option_page.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final controller = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  bool _obscureText = true;
  void _toggle(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  Set<String> options = {"User", "Doctor"};
  String currentItemSelected = selectedTabName;
  String role = selectedTabName;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: controller.fullName,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                              icon: Icon(Icons.person_outline_rounded),
                            ),
                          ),
                          TextFormField(
                            controller: controller.email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'User email',
                              icon: Icon(Icons.mail_outline),
                            ),
                          ),

                          SizedBox(height: 15, ),
                          TextFormField(
                            controller: controller.password,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: 'User Password',
                              icon: InkWell(
                                onTap: (){
                                  _toggle();
                                },
                                child: Icon(Icons.remove_red_eye_rounded),
                              ),
                            ),
                          ),
                          // SizedBox(height: 15,),
                          // TextFormField(
                          //   controller: controller.confirmPassword,
                          //   obscureText: _obscureText,
                          //   decoration: InputDecoration(
                          //     hintText: 'Confirm Password',
                          //     icon: InkWell(
                          //         onTap: (){
                          //           _toggle();
                          //           if(controller.password != controller.confirmPassword){
                          //             Utilis().toastMessage("Password does not match");
                          //           }
                          //         },
                          //         child: Icon(Icons.remove_red_eye_rounded)
                          //     ),
                          //   ),
                          // ),
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

                          SizedBox(height: 15, width: 10,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                            },
                            child: Text(
                              'Already have an account? Login',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          SizedBox(height: 100, width: 100,),

                          InkWell(
                            onTap: () {
                              if (_formKey.currentState != null && _formKey.currentState!.validate()  ){
                                SignupController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim(), controller.fullName.text.trim(),role);
                              }
                              else{
                                // Utilis().toastMessage('Password does not match');
                              }
                              print(role);
                            },
                            child: Container(
                              width: 300,
                              height: 50,
                              child: Center(
                                child: Text(
                                  'SIGN UP with Email',
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
