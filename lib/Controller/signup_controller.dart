import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:DermaVisuals/authentication/authetication_repository.dart';



class SignupController extends GetxController{
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final confirmPassword = TextEditingController();

  void registerUser(String email, String password, String fullName, String role){
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password, fullName, role);
  }
  void LoginUser(String email, String password, String role){
    AuthenticationRepository.instance.LoginUserWithEmailAndPassword(email, password,role);
  }
  void LogoutUser(){
    AuthenticationRepository.instance.logout();
  }
  void phoneAuthentication (String phoneNo, String FullName, String role){
    AuthenticationRepository.instance.phoneAuthentication(phoneNo, FullName, role);
  }
  void forgetPassword(String email){
    AuthenticationRepository.instance.ForgetPassword(email);
  }
}