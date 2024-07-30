import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DermaVisuals/Doctors/VideoAgora/video_call.dart';

import '../../constants/color constants.dart';

class JoinWithCode extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                child: Icon(Icons.arrow_back_ios_new_sharp, size: 35, color: Colors.white,),
                onTap: Get.back,
              ),
            ),
            SizedBox(height: 50),
            Image(
              image: AssetImage('assets/joinwithcode.png'),
              fit: BoxFit.cover,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              "Enter meeting code below",
              style: TextStyle(fontSize: 15,
                  fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Example : abc-efg-dhi"),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(VideoCall(channelName: _controller.text.trim()));
              },
              child: Text("Join",
              style: TextStyle(
                color: Colors.white,
              ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(80, 30),
                backgroundColor: primaryAppColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
