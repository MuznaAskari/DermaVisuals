import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:DermaVisuals/Controller/Otp_controller.dart';

class OTP_Screen extends StatelessWidget {
  const OTP_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OTPController());
    var otp;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "C O",
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 80),
            ),
            Text(
              "D E",
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold , fontSize: 80),
            ),
            Text("verification", style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Enter verification code"),
            SizedBox(height: 20,),
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code){
                otp = code;
                OTPController.instance.verifyOTP(otp);
              },
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  OTPController.instance.verifyOTP(otp);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                ),
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 20,),
                ),
              ),
            )
          ],
        ),
      ) ,
    );
  }
}
