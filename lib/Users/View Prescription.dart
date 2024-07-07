import 'package:DermaVisuals/Components/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FetchPrescription extends StatefulWidget {
  const FetchPrescription({super.key});

  @override

  State<FetchPrescription> createState() => _FetchPrescriptionState();
}

class _FetchPrescriptionState extends State<FetchPrescription> {
  @override
  void initState() {
    super.initState();
    getPhoneNoOrEmail();
    // Fetch prescriptions with a predefined email address
    _fetchPrescriptions();
  }
  List<Map<String, dynamic>> _prescriptions = [];

  String? accountEmail;
  Future <void> getPhoneNoOrEmail ()async {
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser?.email != null) {
        // User signed up with an email
        accountEmail = FirebaseAuth.instance.currentUser!.email;
      } else if (FirebaseAuth.instance.currentUser?.phoneNumber != null) {
        // User signed up with a mobile number
        accountEmail = FirebaseAuth.instance.currentUser!.phoneNumber;
      }
    }
  }


  Future<void> _fetchPrescriptions() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('prescriptions')
          .where('email', isEqualTo: accountEmail)
          .get();

      setState(() {
        _prescriptions = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
      print("Prescription List ${_prescriptions}");
    } catch (e) {
      print('Error fetching prescriptions: $e');
    }
  }
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appbar(context),
      drawer: drawerUser(context, "User"),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: deviceHeight * 0.3,
                width: deviceWidth,
                color: Color(0xFFEBE6DD),
                child: Image.asset("assets/ViewPrescriptionDr-removebg-preview.png"),
              ),
              Container(
                  height: deviceHeight * 0.6,
                  width: deviceWidth,

                  child: ListView.builder(
                        itemCount: _prescriptions.length,
                        itemBuilder: (context, index) {
                          // Assuming 'Date & Time' is stored as a timestamp in Firestore
                          Timestamp timestamp = _prescriptions[index]['Date & Time'];
                          DateTime dateTime = timestamp.toDate();
                          String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                          return ListTile(
                            title: Column(
                              children: [
                                Text(
                                  "Prescription Date: ${formattedDate}",
                                  style: TextStyle(
                                    fontSize: deviceWidth < 800 ? deviceHeight * 0.02: deviceHeight * 0.025,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.asset("assets/ViewPrescription-removebg-preview.png", width: deviceHeight * 0.05, height: deviceHeight * 0.1,),
                                    Text(
                                        "Patient Name: ${_prescriptions[index]['name']}",
                                      style: TextStyle(
                                        fontSize: deviceWidth < 800 ? deviceHeight * 0.02: deviceHeight * 0.025,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Prescribed Medication",
                                  style: TextStyle(
                                    fontSize: deviceWidth < 800 ? deviceHeight * 0.02: deviceHeight * 0.025,
                                  ),
                                ),
                                Text(
                                    _prescriptions[index]['prescription'],
                                  style: TextStyle(
                                    fontSize: deviceWidth < 800 ? deviceHeight * 0.02: deviceHeight * 0.025,
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                  color: Colors.brown[900]!,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                ),
            ],
        ),
      ),
    );
  }
}
