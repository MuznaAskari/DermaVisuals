
import 'package:http/http.dart';
import 'dart:convert';

const appID = '3623fbe7d3d24e0aba55dc0eb1de2b8f';
const appCertificate = '086c795b01f0476c9c1e122b713a39f4';
// const channelName = 'group_chat';
const uid = 0; // 0 for the default uid
const expirationTimeInSeconds = 3600; // 1 hour


// Future<String> fetchAgoraToken() async {
//   final response = await http.get(Uri.parse('http://YOUR_SERVER_ADDRESS/token?channelName=$channelName'));
//
//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     return data['token'];
//   } else {
//     throw Exception('Failed to load token');
//   }
// }
