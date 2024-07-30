import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'package:DermaVisuals/Doctors/VideoAgora/video_call.dart';

import '../../constants/color constants.dart';

class NewMeeting extends StatefulWidget {
  NewMeeting({Key? key}) : super(key: key);

  @override
  _NewMeetingState createState() => _NewMeetingState();
}

class _NewMeetingState extends State<NewMeeting> {
  String _meetingCode = "abcdfgqw";

  @override
  void initState() {
    var uuid = Uuid();
    _meetingCode = uuid.v1().substring(0, 8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                child: Icon(Icons.arrow_back_ios_new_sharp, size: 35),
                onTap: Get.back,
              ),
            ),
            SizedBox(height: 50),
            Image(
              image: AssetImage('assets/newmeeting.png'),
              fit: BoxFit.cover,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              "Enter meeting code below",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
              color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.link),
                    title: SelectableText(
                      _meetingCode,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    trailing: Icon(Icons.copy),
                  )),
            ),
            Divider(thickness: 1, height: 40, indent: 20, endIndent: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Share.share("Meeting Code : $_meetingCode");
              },
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              label: Text("Share invite",
                style: TextStyle(
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
            SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                Get.to(VideoCall(channelName: _meetingCode.trim()));
              },
              icon: Icon(Icons.video_call, color: Colors.white),
              label: Text("start call",
                style: TextStyle(
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
          ],
        ),
      ),
    );
  }
}
