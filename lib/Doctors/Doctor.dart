import 'package:DermaVisuals/Components/appbar.dart';
import 'package:DermaVisuals/Doctors/Prescription.dart';
import 'package:DermaVisuals/Doctors/Video Consultation/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          appBar: appbar(context),
          drawer:  drawerDoctor(context, "Doctor"),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:  (context) => DoctorHome()));
                },
                child: Center(
                  child: Container(
                    width: deviceWidth* 0.9,
                    height: deviceHeight * 0.2,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1E2),
                        borderRadius: BorderRadius.circular(15.0), // Making edges slightly circular
                      ),
                    child:Padding(
                      padding: EdgeInsets.all(deviceWidth * 0.1),
                      child: Row(
                        children: [
                          Text(
                            "Home Screen",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: deviceWidth < 800 ? deviceHeight * 0.02: deviceHeight * 0.025,
                            ),
                          ),
                          SizedBox(width: deviceWidth * 0.12,),
                          Align(
                            alignment: Alignment. centerRight,
                              child: Image.asset("assets/HomePageDoctor.png", width: deviceWidth* 0.3, height: deviceHeight * 0.3,)
                          )
                        ],
                      ),
                    )
                  ),
                ),
              ),
              SizedBox(height: deviceHeight* 0.05,),
              // container 2 video Consultation
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:  (context) => MyHomePage()));
                },
                child: Center(
                  child: Container(
                      width: deviceWidth* 0.9,
                      height: deviceHeight * 0.2,
                      decoration: BoxDecoration(
                        color: Color(0xFFEFE7D0),
                        borderRadius: BorderRadius.circular(15.0), // Making edges slightly circular
                      ),
                      child:Padding(
                        padding: EdgeInsets.all(deviceWidth * 0.1),
                        child: Row(
                          children: [
                            Text(
                              "Video Consultation",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: deviceWidth < 800 ? deviceHeight * 0.02: deviceHeight * 0.025,
                              ),
                            ),
                            SizedBox(width: deviceWidth * 0.01,),
                            Align(
                                alignment: Alignment. centerRight,
                                child: Image.asset("assets/VideoConsultation.png", width: deviceWidth* 0.3, height: deviceHeight * 0.3,)
                            )
                          ],
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(height: deviceHeight* 0.05,),
              // container 3 Prescription
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:  (context) => Prescription()));
                },
                child: Center(
                  child: Container(
                      width: deviceWidth* 0.9,
                      height: deviceHeight * 0.2,
                      decoration: BoxDecoration(
                        color: Color(0xFFD8CDBC),
                        borderRadius: BorderRadius.circular(15.0), // Making edges slightly circular
                      ),
                      child:Padding(
                        padding: EdgeInsets.all(deviceWidth * 0.05),
                        child: Row(
                          children: [
                            Text(
                              "Prescribe Patients",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: deviceWidth < 800 ? deviceHeight * 0.02: deviceHeight * 0.025,
                              ),
                            ),
                            SizedBox(width: deviceWidth * 0.1,),
                            Align(
                                alignment: Alignment. centerRight,
                                child: Image.asset("assets/DoctorPrescription.png", width: deviceWidth* 0.3, height: deviceHeight * 0.3,)
                            )
                          ],
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
