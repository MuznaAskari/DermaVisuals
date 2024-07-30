import 'package:DermaVisuals/Users/User.dart';
import 'package:DermaVisuals/authentication/authetication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DermaVisuals/authentication/authetication_repository.dart';


class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  Future<void> verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(UserHome()) : Get.back();
  }
}