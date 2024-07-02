import 'package:DermaVisuals/constants/color%20constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Checkout extends StatelessWidget  {
  final double totalAmount;

  const Checkout({Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController zipcodeController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40.0,
        backgroundColor: primaryAppColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Text(
                  "Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              //ToDo payment page yet to make
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder:
              //           (context) => PaymentPage(totalprice: totalAmount),
              //     )
              // );
            },
            icon: Icon(Icons.favorite, color: Colors.white),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        child: Center(
          child: InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // Proceed to payment only if all fields are valid
                String name = nameController.text;
                String phone = emailController.text;
                String address = addressController.text;
                String city = cityController.text;
                String country = countryController.text;
                String zipcode = zipcodeController.text;

                // Access Firestore instance
                FirebaseFirestore firestore = FirebaseFirestore.instance;

                // Create a reference to the "checkout0" collection
                CollectionReference checkoutRef =
                firestore.collection('checkout0');

                // Add a new document to the "checkout0" collection
                checkoutRef
                    .add({
                  'name': name,
                  'phone': phone,
                  'address': address,
                  'city': city,
                  'country': country,
                  'zipcode': zipcode,
                })
                    .then((value) {
                  // Data added successfully
                  print('Data stored in Firestore');
                  // You can also show a success message or navigate to a different screen here
                })
                    .catchError((error) {
                  // Error occurred while storing data
                  print('Failed to store data in Firestore: $error');
                  // You can show an error message or handle the error accordingly
                });
                //ToDo Payment page yet to make
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PaymentPage(totalprice: totalAmount,),
                //   ),
                // );
              }
            },
            child: Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 27.0),
                width: 300,
                height: 50,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.payment, color: Colors. yellow,),
                    title: Text(
                      'Proceed to Payment',
                      style: TextStyle(
                        fontFamily: 'Alkatra',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors. white,
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 40.0,
              color: primaryAppColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Container(
                              child: Center(
                                child: Text(
                                  'SHIPPING',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Text(
                          'PAYMENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Text(
                          'CONFIRMATION',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CUSTOMER INFORMATION",
                        style: TextStyle(
                          color: Color(0xFF001D66),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildTextFormField(nameController, context, 'Full Name'),
                      _buildTextFormField(emailController, context, 'Phone No.',),
                      SizedBox(height: 10.0),
                      Text(
                        "DELIVERY INFORMATION",
                        style: TextStyle(
                          color: Color(0xFF001D66),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildTextFormField(addressController, context, 'Address'),
                      _buildTextFormField(cityController, context, 'City'),
                      _buildTextFormField(countryController, context, 'Country'),
                      _buildTextFormField(zipcodeController, context, 'Zip Code'),
                      SizedBox(height: 12.0),
                      Text(
                        "ORDER SUMMARY",
                        style: TextStyle(
                          color: Color(0xFF001D66),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rs. ${totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Divider(thickness: 2, color: Color(0xFF001D66)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildTextFormField(
      TextEditingController controller,
      BuildContext context,
      String labelText,
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: 75.0,
            child: Text(
              labelText,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (labelText == 'Phone No.') {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  } else if (value.length != 11) {
                    return 'Phone number must be 11 digits';
                  } else if (!value.startsWith('0')) {
                    return 'Phone number must start with 0';
                  }else if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Phone no. must contain only integers';
                  }
                }
                if(labelText == 'Full Name' || labelText == 'City' || labelText == 'Country' ){
                  if (value == null || value.isEmpty) {
                    return 'Field must be filled';
                  }else if (RegExp(r'\d').hasMatch(value)) {
                    return 'Field cannot contain integers';
                  }
                }
                else if(labelText == 'Zip Code'){
                  if (value == null || value.isEmpty) {
                    return 'Zip Code is required';
                  } else if (value.length != 5) {
                    return 'Zip code must be 5 digits';
                  }else if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Zip code must contain only integers';
                  }
                }
                else if(labelText == 'Address'){
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  }
                }
                return null;
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 10.0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpwardTriangleIcon extends StatelessWidget {
  final double size;
  final Color color;

  const UpwardTriangleIcon({
    Key? key,
    this.size = 24,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: UpwardTrianglePainter(color),
    );
  }
}

class UpwardTrianglePainter extends CustomPainter {
  final Color color;

  UpwardTrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    // path.moveTo(size.width / 2, 0);
    // path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.close();
    path.moveTo(size.width / 2, 0); // Start from the top-left quarter point
    path.lineTo(size.width , size.height); // Draw a line to the top-right three-quarter point
    path.lineTo(0, size.height); // Draw a line to the bottom-left quarter point
    path.close(); // Close the path to complete the triangle

    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}