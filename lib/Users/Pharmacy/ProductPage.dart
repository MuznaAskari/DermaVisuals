import 'dart:convert';

import 'package:DermaVisuals/constants/color%20constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ToastMessage/Utilis.dart';
import 'CartManager.dart';
import 'CartPage.dart';
import 'home_controller.dart';

class ProductsPage extends StatelessWidget {
  final String category;

  const ProductsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(category),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Text('No products available for this category.');
          }

          final products = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two cards in each row
              childAspectRatio: 0.55, // Adjust the aspect ratio as needed
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = products[index] as DocumentSnapshot;
              // Access the product data from the document
              String productName = document['name'];
              String productDesc = document['desc'];
              int productPrice = document['price'];
              String productImage = document['image'];

              return GestureDetector(
                onTap: () {
                  // Navigate to product details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        productName: productName,
                        productImage: productImage,
                        productPrice: productPrice,
                        productDesc: productDesc,
                      ),
                    ),
                  );
                },
                child: Card(
                        margin: EdgeInsets.all(10.0),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                productImage,
                                width: deviceWidth * 0.15,
                                height: deviceHeight * 0.15,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                productName,
                                style: TextStyle(
                                  color: Color(0xFF001D66),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                ' Rs. ${productPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Color(0xFF001D66),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // SizedBox(height: 10.0),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  CartItemModel cartItem = CartItemModel(
                                    productName: productName,
                                    productImage: productImage,
                                    productPrice: productPrice,
                                    index: 1,
                                  );
                                  cartItems.add(cartItem);
                                  CartManager.addToCart(cartItem);
                                  Utilis().toastMessage('$productName has been added to the cart');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryAppColor,// Set the desired background color
                                  foregroundColor: Colors.white,
                                ),
                                child: Text('Add to Cart'),
                              ),
                              SizedBox(height: deviceHeight * 0.01,)
                            ],
                          ),
                        ),
                    ),
              );
            },
          );
        },
      ),
    );
  }

}
class ProductDetailsPage extends StatelessWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final String productDesc;

  const ProductDetailsPage({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDesc,

  });

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(productName),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05, vertical: deviceHeight* 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 1.0),

            Image.network(
              productImage,
              width: deviceWidth * 0.5,
              height: deviceHeight * 0.3,
              fit: BoxFit.cover,
            ),
            SizedBox(height: deviceHeight * 0.1),
            Center(
              child:Text(
                productDesc,
                style: TextStyle(
                  fontSize: deviceWidth< 800 ? deviceHeight * 0.02 : deviceHeight* 0.025,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,


              ),
            ),
            SizedBox(height: deviceHeight * 0.05),

            Text(
              'Rs. ${productPrice.toString()}',
              style: TextStyle(
                fontSize: deviceWidth< 800 ? deviceHeight * 0.02 : deviceHeight* 0.025,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: deviceHeight * 0.075),
            SizedBox(
              width: deviceWidth * 0.8, // Set the desired width
              child: ElevatedButton(
                onPressed: () {
                  CartItemModel cartItem = CartItemModel(
                    productName: productName,
                    productImage: productImage,
                    productPrice: productPrice,
                    index: 1,
                  );
                  cartItems.add(cartItem);
                  Utilis().toastMessage('$productName has been added to the cart');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryAppColor,
                  foregroundColor: Colors.white,// Set the desired background color
                  textStyle: GoogleFonts.roboto(
                    fontSize: deviceWidth< 800 ? deviceHeight * 0.02 : deviceHeight* 0.025,
                  )
                ),
                child: Text('Add to Cart'),
              ),
            ),

          ],
        ),
      ),

    );
  }
}