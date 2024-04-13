import 'package:DermaVisuals/Components/appbar.dart';
import 'package:DermaVisuals/constants/color%20constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Login/Login.dart';
import 'CartPage.dart';
import 'ProductPage.dart';
import 'home.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  int cartItemCount = 0;

  final List<BottomNavigationBarItem> navbarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    //ToDo: to inclue or remove chatbor is something yet to be decided
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.chat_bubble_outline),
    //   label: 'ChatBot',
    // ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_shopping_cart_outlined),
      label: 'Cart',
    ),
    // ToDo: we have already asked user to login so we dont need accounts
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.person_outline_rounded),
    //   label: 'Account',
    // ),
  ];


  final List<Widget> navBody = [
    Home(),
    const CategoryPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Image.asset("assets/DermaVisuals_logo.png", width: 200,),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartItemCount > 0) Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
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

        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      drawer: drawerUser(context, "User"),
      body: Column(
          children: [
            // Code for Search bar
            Expanded(
              child: Padding(
                    padding: EdgeInsets.all(8.0),

                          child: TextFormField(
                            decoration: InputDecoration(

                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey, // Set border color here
                                  width: 4.0, // Set border width here
                                ),
                                borderRadius: BorderRadius.circular(10.0), // Set border radius here
                              ),
                              suffixIcon: Icon(Icons.search),
                              filled: true,
                              // fillColor: Colors.white,
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Colors.grey[900]!,
                                fontSize: deviceHeight * 0.02
                              ),
                            ),
                          ),
                  ),
                ),
            // Code for categories
            Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                child: SingleChildScrollView(
                  child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildCategoryCard(
                              context,
                              'Prescription Drugs',
                              'assets/Pharmacy-Categories/medicine.png',
                            ),
                            buildCategoryCard(
                              context,
                              'Hand Cream',
                              'assets/Pharmacy-Categories/HandCare2.png',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildCategoryCard(
                              context,
                              'Hair Care',
                              'assets/Pharmacy-Categories/HairCare2.png',
                            ),
                            buildCategoryCard(
                              context,
                              'Body Care',
                              'assets/Pharmacy-Categories/Sunscreen and Moisturizers.png',
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildCategoryCard(
                              context,
                              'Skin Care',
                              'assets/Pharmacy-Categories/SkinCare.png',
                            ),
                            buildCategoryCard(
                              context,
                              'Face Wash',
                              'assets/Pharmacy-Categories/Face Wash.png',
                            ),
                          ],
                        ),
                      ],
                    ),
                ),
                ),
          ],
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value >= navbarItems.length ? 0 : controller.currentNavIndex.value,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontFamily: 'semibold'),
          unselectedItemColor: Colors.white,
          backgroundColor: primaryAppColor,
          type: BottomNavigationBarType.fixed,
          items: navbarItems,

          onTap: (value) {
            setState(() {
              controller.currentNavIndex.value = value;
              switch (value){
                case 0:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  break;
                  //ToDo yet to decide if we want chatbot or not
                // case 1:
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatScreen()));
                //   break;
                case 1:
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                  break;
                // case 2:
                //   Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen()));
                //   break;
              }

            });
          },
        ),
      ),
    );
  }

  Widget buildCategoryCard(
      BuildContext context, String title, String imageUrl) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsPage(category: title),
          ),
        );
      },
      child: Container(
        height: deviceHeight* 0.2,
        width: deviceWidth * 0.42,
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  imageUrl,
                  width: deviceHeight * 0.15,
                  height: deviceHeight * 0.15,
                ),
                Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF001D66),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Category Page'),
      ),
    );
  }
}