import 'package:DermaVisuals/constants/color%20constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Checkout.dart';
import '../../Doctors/Prescription.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IconColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
            'Shopping Cart',
            style: GoogleFonts.oxygen(
              textStyle: GoogleFonts.roboto(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            )

        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: EdgeInsets.only(left: 22.0, right: 16.0, top: 22.0),
          //   child:
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cartItems.length} Products',
                  style: TextStyle(fontSize: 14.0),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      editMode = !editMode;
                    });
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 8,
            color: primaryAppColor,
            indent: 22.0,
            endIndent: 22.0,
            thickness: 2,

          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartItem(
                  cartItems: cartItems[index],
                  editMode: editMode,
                  onDelete: () {
                    setState(() {
                      cartItems.removeAt(index);
                    });
                  },
                  onIncrement: () {
                    setState(() {
                      cartItems[index].quantity++;
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      if (cartItems[index].quantity > 1) {
                        cartItems[index].quantity--;
                      }
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          OrderSummary(
            subtotal: cartItems.fold(
                0, (sum, cartItems) => sum + (cartItems.productPrice * cartItems.quantity)),
            deliveryFee: 200,
            totalAmount: cartItems.fold(
                0, (sum, cartItems) => sum + (cartItems.productPrice * cartItems.quantity).toInt()) + 200,
          ),
          SizedBox(height: 16.0),

          SizedBox(height: 10,),
          Center(
            child: Container(
              width: 300,
              height: 40,
              margin: EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Checkout(totalAmount: cartItems.fold(
                        0, (sum, cartItems) => sum + (cartItems.productPrice * cartItems.quantity).toInt()) + 200,),));
                },
                style:ElevatedButton.styleFrom(
                  backgroundColor: primaryAppColor, // Set the desired background color
                ),
                child: Text('Checkout',
                    style: GoogleFonts.oxygen(
                      textStyle:TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final CartItemModel cartItems;
  final bool editMode;
  final VoidCallback onDelete;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItem({
    Key? key,
    required this.cartItems,
    required this.editMode,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [

            Image.network(
              cartItems.productImage,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItems.productName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Item no. ${cartItems.index + 1}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'Rs.${cartItems.productPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (editMode)
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.close),
              ),
            if (!editMode)
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onDecrement,
                      icon: Icon(Icons.remove, size: 14.0,),
                      padding: EdgeInsets.zero,
                    ),
                    Text(
                      cartItems.quantity.toString(),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    IconButton(
                      onPressed: onIncrement,
                      icon: Icon(Icons.add, size: 14.0,),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double totalAmount;

  const OrderSummary({
    Key? key,
    required this.subtotal,
    required this.deliveryFee,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal'),
              Text('Rs.${subtotal.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Fee'),
              Text('Rs.${deliveryFee.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: 8.0),
          Divider(
            height: 1,
            color: Colors.grey[400],
          ),
          SizedBox(height: 8.0),
          Row(
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
                'Rs. ${(totalAmount).toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0)
        ],
      ),
    );
  }
}

class CartItemModel {
  final String productName;
  final int productPrice;
  final String productImage;
  int quantity;
  final int index;

  CartItemModel({
    required this.productName,
    required this.productPrice,
    required this.productImage,
    this.quantity = 1,
    required this.index,
  });
}

List<CartItemModel> cartItems = [];

