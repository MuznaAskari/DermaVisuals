import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/color constants.dart';
import 'joinWithCode.dart';
import 'new_meeting.dart';

class VideoInterfacePage extends StatelessWidget {
  const VideoInterfacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Conference"),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
          child: ElevatedButton.icon(
            onPressed: () {
              Get.to(NewMeeting());
            },
            icon: Icon(Icons.add, color: Colors.white,),
            label: Text("New Meeting", style: TextStyle(
              color: Colors.white,
             ),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(350, 30),
              backgroundColor: primaryAppColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        Divider(
          thickness: 1,
          height: 40,
          indent: 40,
          endIndent: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: OutlinedButton.icon(
            onPressed: () {
              Get.to(JoinWithCode());
            },
            icon: Icon(Icons.margin, color: Colors.white,),
            label: Text("Join with code", style: TextStyle(
              color: Colors.white,
             ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: primaryAppColor,
              side: BorderSide(color: Colors.indigo),
              fixedSize: Size(350, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ),
        SizedBox(height: 90),
        Image(
          image: AssetImage('assets/Video_Consultation-removebg-preview.png'),
        )
      ]),
    );
  }
}


