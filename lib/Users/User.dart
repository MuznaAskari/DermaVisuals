import 'dart:io';

import 'package:DermaVisuals/Components/button.dart';
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
        drawer: drawerUser(context, "User"),

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
                  TextureButton(clickImage, Icon(Icons.camera_alt_outlined), "Click a Photo", context),
                  SizedBox(width: 20),
                  TextureButton(pickImage, Icon(Icons.photo_album_outlined), "Choose image from Gallery", context),
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

