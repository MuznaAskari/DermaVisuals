import 'package:DermaVisuals/Login/Login.dart';
import 'package:DermaVisuals/Login/Signup_with_phone.dart';
import 'package:DermaVisuals/SplashScreen.dart';
import 'package:DermaVisuals/authentication/authetication_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String selectedTabName = "User"; // Global variable to store the selected tab name

class LoginOption extends StatelessWidget {
  const LoginOption({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFA86A44),
            title: Center(child: Image.asset("assets/Untitled design (4).png", width: 250,)),
            bottom: TabBar(
              indicatorColor: Colors.yellow[50],
              tabs: [
                Tab(
                  icon: Icon(Icons.person_outline_rounded),
                  text: "User",
                ),
                Tab (
                  icon: Icon(Icons.medication),
                  text: "Doctor",
                ),
              ],
              onTap: (index){
                if (index == 0){
                  selectedTabName = "User";
                }
                else if (index == 1){
                  selectedTabName = "Doctor";
                }
              },
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.brown[50],
                    image: DecorationImage(
                        image: AssetImage("assets/login_option_bg.png"),
                        fit: BoxFit.cover),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Image.asset("assets/splashScreen_skin_Scan-removebg-preview.png"),
                        // SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            child: ListTile(
                              leading: Icon(Icons.email,color:Color(0xFFA86A44)),
                              title: Text(
                                "Login with Email",
                                style: GoogleFonts.alkatra(
                                    color: Color(0xFFA86A44)
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_phone()));
                          },
                          child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: Icon(Icons.phone_android,color:Color(0xFFA86A44)),
                                title: Text(
                                  "Login with Phone",
                                  style: GoogleFonts.alkatra(
                                      color: Color(0xFFA86A44)
                                  ),
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            AuthenticationRepository.instance.signInWithGoogle(selectedTabName);
                          },
                          child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: Image.asset("assets/google_icon-removebg-preview.png", height: 25, width:25,),
                                title: Text(
                                  "Login with Google",
                                  style: GoogleFonts.alkatra(
                                      color: Color(0xFFA86A44)
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //Doctor Tab
              Center(
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.brown[50],
                    image: DecorationImage(
                        image: AssetImage("assets/Doctor Portal.png"),
                        fit: BoxFit.cover),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Image.asset("assets/splashScreen_skin_Scan-removebg-preview.png"),
                        // SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            child: ListTile(
                              leading: Icon(Icons.email,color:Color(0xFFA86A44)),
                              title: Text(
                                "Login with Email",
                                style: GoogleFonts.alkatra(
                                    color: Color(0xFFA86A44)
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_phone()));
                          },
                          child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: Icon(Icons.phone_android,color:Color(0xFFA86A44)),
                                title: Text(
                                  "Login with Phone",
                                  style: GoogleFonts.alkatra(
                                      color: Color(0xFFA86A44)
                                  ),
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            AuthenticationRepository.instance.signInWithGoogle(selectedTabName);
                          },
                          child: Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: Image.asset("assets/google_icon-removebg-preview.png", height: 25, width:25,),
                                title: Text(
                                  "Login with Google",
                                  style: GoogleFonts.alkatra(
                                      color: Color(0xFFA86A44)
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
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
