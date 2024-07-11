import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;

  RxList<String> cartItems = <String>[].obs;

  void addToCart(String productName) {
    cartItems.add(productName);
  }
}