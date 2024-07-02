import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget TextureButton(VoidCallback buttonFunction, Icon buttonIcon ,String buttonText, BuildContext context){
  var deviceWidth = MediaQuery.of(context).size.width;
  var deviceHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        buttonFunction();
      },
      child: Container(
        width: deviceWidth * 0.7,
        height: deviceHeight * 0.075,
        child: Center(
          child: ListTile(
            leading: buttonIcon,
            title: Text(
              buttonText,
              style: GoogleFonts.montserrat(
                color: Colors.brown[900],
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(
                  "assets/Brown button texture.jpeg"),
              fit: BoxFit.cover
          ),
        ),
      ),
    ),
  );
}