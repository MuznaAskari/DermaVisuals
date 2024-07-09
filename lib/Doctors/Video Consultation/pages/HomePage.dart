import 'package:DermaVisuals/Components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'CallPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  bool _validateError = false;
  // final Permission _permissionHandler = Permission();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<void> onJoin() async{
    setState(() {
      myController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    await [Permission.camera, Permission.microphone].request();

    Navigator.push(context,
        MaterialPageRoute(
          builder: (context)=> CallPage(channelName: myController.text),)
    );
  }

  Future<void> _handleCameraAndMicPermissions() async {
    await [Permission.camera, Permission.microphone].request();
  }
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: appbar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/Video_Consultation-removebg-preview.png", height: deviceHeight * 0.35,),
            Text('Agora Group Video Call Demo',
              style: TextStyle(color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Container(
              width: 300,
              child: TextFormField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Channel Name',
                  labelStyle: TextStyle(color: Colors.brown[900]),
                  hintText: 'test',
                  hintStyle: TextStyle(color: Colors.black45),
                  errorText: _validateError
                      ? 'Channel name is mandatory'
                      : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Container(
              width: 90,
              child: MaterialButton(
                onPressed: onJoin,
                height: 40,
                color: Colors.brown[900],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Join', style: TextStyle(color: Colors.white)),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}