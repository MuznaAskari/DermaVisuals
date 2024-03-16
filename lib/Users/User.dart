import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:DermaVisuals/Components/appbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Controller/signup_controller.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final controller = Get.put(SignupController());
  String? accountEmail;

  File? image;
  UploadTask? uploadTask;
  Future uploadFile() async{
    final path = 'CustomerImages/${File(image!.path)}';
    final file = File(image!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image ${e}');
    };
  }
  Future clickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image ${e}');
    };
  }
    @override
    Widget build(BuildContext context) {
      if (FirebaseAuth.instance.currentUser != null) {
        if (FirebaseAuth.instance.currentUser?.email != null) {
          // User signed up with an email
          accountEmail = FirebaseAuth.instance.currentUser!.email;
        } else if (FirebaseAuth.instance.currentUser?.phoneNumber != null) {
          // User signed up with a mobile number
          accountEmail = FirebaseAuth.instance.currentUser!.phoneNumber;
        }
      } else {
        accountEmail = 'No Email';
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFA86A44),
          title: Image.asset("assets/DermaVisuals_logo.png", width: 200,),
          actions: [
            if(image != null)
              InkWell(
                onTap: (){
                  uploadFile();
                },
                child: Center(
                  child: Container(
                    height: 30,
                    width: 60,
                    child: Text(
                        "SAVE",
                      style: GoogleFonts.alkatra(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        drawer: drawer(context, "User"),
        // drawer: Align(
        //   alignment: Alignment.centerLeft,
        //   child: Drawer(
        //     child: ListView(
        //       children: [
        //         UserAccountsDrawerHeader(
        //             decoration: BoxDecoration(
        //               color: Color(
        //                   0xFFA86A44), // Set the background color to brown
        //             ),
        //             accountName: Text(
        //                 '${FirebaseAuth.instance.currentUser?.displayName }'),
        //             accountEmail: Text('${accountEmail}')
        //           // currentAccountPicture: CircleAvatar(
        //           //   backgroundImage: AssetImage('assets/profile_image.jpg'),
        //           // ),
        //         ),
        //         InkWell(
        //           onTap: () {
        //             SignupController.instance.LogoutUser();
        //           },
        //           child: ListTile(
        //             leading: Icon(Icons.logout),
        //             title: Text("Logout"),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildProgress(),
              Container(
                height: MediaQuery.sizeOf(context).height - 400,
                width: MediaQuery.sizeOf(context).width - 100,
                child: image != null ? Image.file(image!) : Image.asset(
                    "assets/default image.png"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        clickImage();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: MediaQuery.of(context).size.height - 770,
                        child: Center(
                          child: ListTile(
                            leading: Icon(Icons.camera_alt_outlined),
                            title: Text(
                              "Click a Photo",
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
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        height: MediaQuery.of(context).size.height - 770,
                        child: Center(
                          child: ListTile(
                            leading: Icon(Icons.photo),
                            title: Text(
                              "Choose image from Gallery",
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
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder: (context, snapshot){
      if (snapshot.hasData){
        final data = snapshot.data!;
        double progress = data.bytesTransferred/ data.totalBytes;
        if (progress == 100.0){
          return Text("Uploaded Succesfully!");
        }else {
              return SizedBox(
                height: 10,
                child: LinearProgressIndicator(
                  value: progress,
                  color: Colors.green,
                  backgroundColor: Colors.grey,
                ),
              );
            }
          }else{
        return Text(
            "Save Image to generate results",
        );
      }
    }
  );
  }

