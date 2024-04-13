import 'package:DermaVisuals/Components/button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/appbar.dart';

class Prescription_Upload extends StatefulWidget {
  const Prescription_Upload({Key? key}) : super(key: key);

  @override
  State<Prescription_Upload> createState() => _Prescription_UploadState();
}

class _Prescription_UploadState extends State<Prescription_Upload> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future UploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download link ${urlDownload}');

    setState(() {
      uploadTask = null ;
    });
  }
  Future SelectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      drawer: drawerDoctor(context, "Doctor"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            if (pickedFile != null)
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.grey[100],
                  child: Center(
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

            SizedBox(height: 20,),

            Center(
                child: TextureButton(SelectFile, Icon(Icons.select_all),"Select File", context)
            ),
            SizedBox(height: 10,),
            Center(
                child: TextureButton(UploadFile, Icon(Icons.upload_file_outlined),"Upload",context)
            ),

            SizedBox(height: 20,),
            BuildProgress(),
          ],
        ),
      ),
    );
  }
  Widget BuildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context , snapshot){
        if(snapshot.hasData){
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                ListTile(
                  leading: (100 * progress).roundToDouble() == 100
                      ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  )
                      : null,
                  title: Center(
                    child: Text(
                      '${(100*progress).roundToDouble()}%',
                      style: TextStyle( color: Colors.white),
                    ),
                  ),),
              ],
            ),
          );
        }
        else{
          return const SizedBox(height: 50,);
        }
      }
  );
}
