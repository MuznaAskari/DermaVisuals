import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget TextureButton(VoidCallback buttonFunction, Icon buttonIcon ,String buttonText, BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        buttonFunction();
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: MediaQuery.of(context).size.height - 770,
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