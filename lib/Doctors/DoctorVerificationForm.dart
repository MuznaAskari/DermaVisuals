import 'dart:io';

import 'package:DermaVisuals/Components/appbar.dart';
import 'package:DermaVisuals/Components/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class DoctorVerificationForm extends StatefulWidget {
  @override
  _DoctorVerificationFormState createState() => _DoctorVerificationFormState();
}

class _DoctorVerificationFormState extends State<DoctorVerificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _experienceController = TextEditingController();
  XFile? _licenseImage;

  Future<void> _pickLicenseImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _licenseImage = pickedImage;
      });
    }
  }
  // submit doctor information to firebase
  // submit prescription data to firebase
  Future<void> _submitDoctorVerification() async {
    if (_formKey.currentState!.validate() && _licenseImage != null) {
      try {
        // Upload the license image to Firebase Storage
        final storageRef = FirebaseStorage.instance.ref().child('licenses/${_licenseImage!.name}');
        await storageRef.putFile(File(_licenseImage!.path));
        final imageUrl = await storageRef.getDownloadURL();

        // Save doctor information along with the image URL to Firestore
        await FirebaseFirestore.instance.collection('doctorVerification').add({
          'name': _nameController.text,
          'qualification': _qualificationController.text,
          'experience': _experienceController.text,
          'licenseImageUrl': imageUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification submitted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting verification: $e')),
        );
      }
    } else if (_licenseImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a license image')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appbar(context),
      drawer:  drawerDoctor(context, "Doctor"),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Doctor Verification Form",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceWidth < 800 ? deviceHeight * 0.025: deviceHeight * 0.03,
                  color: Color(0xFF6D4C41),
                ),
              ),
              SizedBox(height: deviceHeight* 0.1,),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _qualificationController,
                decoration: InputDecoration(
                  labelText: 'Qualification',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your qualification';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _experienceController,
                decoration: InputDecoration(
                  labelText: 'Experience (years)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your experience';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Upload License Image',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _pickLicenseImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD8CDBC), // Light brown background color
                      foregroundColor: Color(0xFF6D4C41), // Dark brown text color
                    ),
                    child: Text('Choose Image'),
                  ),
                  SizedBox(width: 16.0),
                  _licenseImage == null
                      ? Text('No image selected')
                      : Image.file(
                    File(_licenseImage!.path),
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextureButton(
                      () {
                        _submitDoctorVerification();
                      },
                  Icon(Icons.upload_file_outlined),
                  "Complete Verification",
                  context),
            ],
          ),
        ),
      ),
    );
  }
}
