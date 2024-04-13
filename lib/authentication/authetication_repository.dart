import 'package:DermaVisuals/Doctors/Doctor.dart';
import 'package:DermaVisuals/Login/Login_option_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DermaVisuals/Login/Login.dart';
// import 'package:pharma_glow/Prescription.dart';
import 'package:DermaVisuals/Login/Signup.dart';
import 'package:DermaVisuals/ToastMessage/Utilis.dart';
import 'package:DermaVisuals/authentication/exception/signup_email_password_failure.dart';
import 'package:DermaVisuals/main.dart';
import 'package:DermaVisuals/Users/User.dart';
import 'package:DermaVisuals/SplashScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();


  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, (User? user) => _setInitialScreen(user));
    // ever(firebaseUser, _setInitialScreen);
  }

   void _setInitialScreen(User? user) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(() => LoginOption());
      } else {
        FirebaseFirestore.instance.collection('users').doc(user.uid).get().then(
              (DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              if (documentSnapshot.get('role') == "User") {
                Get.offAll(() => UserHome());
              } else if (documentSnapshot.get('role') == "Doctor") {
                Get.offAll(() => DoctorHome());
              }
            }
          },
        );
      }
    });
  }
  // _setInitialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() => LoginScreen());
  //   } else {
  //     FirebaseFirestore.instance.collection('users').doc(user!.uid)
  //         .get().then((DocumentSnapshot documentSnapshot) {
  //       if (documentSnapshot.exists) {
  //         if (documentSnapshot.get('role') == "User") {
  //           Get.offAll(() => UserHome());
  //         } else if (documentSnapshot.get('role') == "Doctor") {
  //           Get.offAll(() => DoctorHome());
  //         }
  //       }
  //     });
  //   }
  // }

  //   user == null
  //       ? Get.offAll(() => SplashScreen())
  //       : Get.offAll(() => UserHome());

  // _setInitialScreen(User? user) {
  //   Get.offAll(()=> HomePage());
  //   user == null
  //       ? Get.offAll(() => LoginScreen())
  //       : Get.offAll(() => HomePage());
  //   if (user != null) {
  //     Get.offAll(() => HomePage());
  //   }
  // }

  // phone authentication code
  Future<void> phoneAuthentication(String phoneNo, String FullName,
      String role) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
          await _auth.currentUser?.updateDisplayName(FullName);
          signInAccordingToRole(role);
          postDetailsToFirestore(phoneNo, role);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phone number is In-valid.');
          } else {
            Get.snackbar('Error', 'Something went wrong. Please try again.');
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
    }
  }

// OTP verification code
  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: this.verificationId.value,
          smsCode: otp,
        ),
      );

      return credentials.user != null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP. Please try again.');
      return false;
    }
  }

  Future <void> signInWithGoogle(String role) async {
    //code 1

    // GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // AuthCredential credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );
    // if (googleUser != null) {
    //   postDetailsToFirestore( googleUser.email ?? "", role);
    //   // Now you can use the 'email' variable as needed.
    // }
    //
    // signInAccordingToRole(role);

    //code 2

    // GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['email'])
        .signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    if (googleUser != null) {
      String email = googleUser.email;
      UserCredential userCredential = await _auth.signInWithCredential(
          credential).then((value) =>
          postDetailsToFirestore(email, role));
      User? user = userCredential.user;
    }
  }

  Future <void> createUserWithEmailAndPassword(String email, String password,
      String fullName, String role) async {
    //creates a user
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password).then((value) =>
      {
        postDetailsToFirestore(email, role)
      }).catchError((e) {});
      await _auth.currentUser?.updateDisplayName(fullName);
      // await _auth.currentUser?.updatePhotoURL(photoUrl);
      firebaseUser.value = _auth.currentUser;
      if (firebaseUser.value != null && role == "User") {
        Get.offAll(() => UserHome());
      }
      else if (firebaseUser.value != null && role == "Doctor") {
        Get.offAll(() => DoctorHome());
      }
      else {
        Get.offAll(() => LoginScreen());
      }
      _setInitialScreen(firebaseUser.value);
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndpasswordFailure.code(e.code);
      print("Firebase Auth Exception - ${ex.message}");
      throw ex;
      // Handle the exception
    } catch (_) {
      const ex = SignUpWithEmailAndpasswordFailure();
      print("Exception - ${ex.message}");
      throw ex;
      // Handle other exceptions
    }
  }

  postDetailsToFirestore(String identifier, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'identifier': identifier, 'role': role});
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => LoginPage()));
    // }
  }

  signInAccordingToRole(role) {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (firebaseUser.value != null && documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "User") {
          Get.offAll(() => UserHome());
        } else if (firebaseUser.value != null &&
            documentSnapshot.get('role') == "Doctor") {
          Get.offAll(() => DoctorHome());
        } else {
          Get.to(() => const LoginScreen());
          Utilis().toastMessage(
              "Either the Login credentials or the portal is incorrect");
        };
      }
    });
  }

  Future <void> LoginUserWithEmailAndPassword(String email, String password,
      String role) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        print('Role retrieved from document: $role');
        if (documentSnapshot.get('role') == "User") {
          Get.offAll(() => UserHome());
        } else if (firebaseUser.value != null &&
            documentSnapshot.get('role') == "Doctor") {
          Get.offAll(() => DoctorHome());
        } else {
          Get.to(() => const LoginScreen());
          Utilis().toastMessage(
              "Either the Login credentials or the portal is incorrect");
        }
      });
    }
    // if (firebaseUser.value != null) {
    //   if(role == "UserHome")
    //     Get.offAll(() => UserHome());
    //   else if (role == "DoctorHome")
    //     Get.offAll(() => DoctorHome());
    // } else{
    //   Get.to(() => const LoginScreen());
    // }
    on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndpasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      // Utilis().toastMessage('${firebaseUser.value}');
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndpasswordFailure();
      print('EXCEPTION - ${ex.message}');
      Utilis().toastMessage('${ex.message}');
      throw ex;
    }
  }
    Future<void> logout() async {
      await _auth.signOut();
      Get.offAll(LoginScreen());
    }

    // Forget Password
    Future<void> ForgetPassword(String email) async {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        Utilis().toastMessage('Recovery Password has been sent to your email');
      }).onError((error, stackTrace) {
        Utilis().toastMessage(error.toString());
      }
      );
    }
  }
