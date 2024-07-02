import 'package:DermaVisuals/Components/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/appbar.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _prescriptionController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _prescriptionController.dispose();
    super.dispose();
  }

  // submit prescription data to firebase
  Future<void> _submitPrescription() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('prescriptions').add({
          'email': _emailController.text,
          'name': _nameController.text,
          'prescription': _prescriptionController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prescription submitted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting prescription: $e')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appbar(context),
      drawer: drawerDoctor(context, "Doctor"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "PRESCRIPTION",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth < 800 ? deviceHeight * 0.025: deviceHeight * 0.03,
                  color: Color(0xFF6D4C41)
                ),
              ),
              SizedBox(height: deviceHeight * 0.1,),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Patient Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _prescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Prescription Medicines',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter prescription medicines';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextureButton(
                      () {
                        if (_formKey.currentState!.validate()) {
                          // Process the input (e.g., send it to a server or save it locally)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          _submitPrescription();
                        }
                      },
                  Icon(Icons.local_pharmacy_outlined),
                  "Submit Prescription", context),
            ],
          ),
        ),
      ),
    );
  }
}


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
