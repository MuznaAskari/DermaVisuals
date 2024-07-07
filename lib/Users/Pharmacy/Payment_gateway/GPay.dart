import 'dart:io';
import 'package:DermaVisuals/constants/color%20constants.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import '../../../ToastMessage/Utilis.dart';
import '../CartManager.dart';
import '../CartPage.dart';
import '../Checkout.dart';
import 'paymentSuccessfulPage.dart';
import 'payment_config.dart';
import '../home_page.dart';


class PaymentPage extends StatefulWidget {
  final double totalprice;
  const PaymentPage({Key? key,required this.totalprice,}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late double totalprice;
  String os = Platform.operatingSystem;
  late ApplePayButton applePayButton;
  late GooglePayButton googlePayButton;

  @override
  void initState() {
    super.initState();
    totalprice = widget.totalprice;

    applePayButton = ApplePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
      paymentItems: paymentItems,
      style: ApplePayButtonStyle.black,
      width: double.infinity,
      height: 50,
      type: ApplePayButtonType.buy,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: _navigateToPaymentSuccessfulPage,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );

    googlePayButton = GooglePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: paymentItems,
      type: GooglePayButtonType.pay,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: _navigateToPaymentSuccessfulPage,
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  List<PaymentItem> get paymentItems {
    List<CartItemModel> cartItems = CartManager.getCartItems();

    List<PaymentItem> paymentItems = [];

    for (CartItemModel item in cartItems) {
      paymentItems.add(
        PaymentItem(
          label: item.productName,
          amount: item.productPrice.toString(),
          status: PaymentItemStatus.final_price,
        ),
      );
    }

    return paymentItems;
  }

  void _navigateToPaymentSuccessfulPage(dynamic paymentResult) {
    Utilis().toastMessage('STATUS UPDATED');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentSuccessfulPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: const Center(
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
            onPressed: () {},
            icon: Icon(Icons.favorite, color: Colors.white),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 40.0,
            color: primaryAppColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    child: const Center(
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
                                'PAYMENT',
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
                    child: const Center(
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    SizedBox(height: 30.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (Platform.isIOS) applePayButton,
                        if (!Platform.isIOS) googlePayButton,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}