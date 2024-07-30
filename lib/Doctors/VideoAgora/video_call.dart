import 'dart:convert';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VideoCall extends StatefulWidget {
  final String channelName;

  VideoCall({required this.channelName});

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  late AgoraClient _client;
  bool _loading = true;
  String tempToken = "";
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    String link =
        "https://50ad2a17-05de-4b86-ae3a-f8f00ca5fd9d-00-3j3w9cjq8c8mz.pike.replit.dev/access_token?channelName=${widget.channelName}";

    try {
      Response _response = await get(Uri.parse(link));
      if (_response.statusCode == 200) {
        Map data = jsonDecode(_response.body);
        tempToken = data["token"];
        _client = AgoraClient(
          agoraConnectionData: AgoraConnectionData(
            appId: "3623fbe7d3d24e0aba55dc0eb1de2b8f",
            tempToken: tempToken,
            channelName: widget.channelName,
          ),
          enabledPermission: [Permission.camera, Permission.microphone],
        );
        await _client.initialize();
        setState(() {
          _loading = false;
        });
      } else {
        throw Exception('Failed to load token');
      }
    } catch (e) {
      setState(() {
        _loading = false;
        errorMessage = 'Error fetching token: $e';
      });
      // Print the error message for debugging purposes
      print('Error fetching token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : errorMessage.isNotEmpty
            ? Center(
          child: Text(errorMessage),
        )
            : Stack(
          children: [
            AgoraVideoViewer(
              client: _client,
            ),
            AgoraVideoButtons(client: _client),
          ],
        ),
      ),
    );
  }
}
