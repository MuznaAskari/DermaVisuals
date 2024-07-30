import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.grey[100],
      width: screenWidth,
      height: screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: Colors.grey[100],
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search",
                ),
              ),
            ),
            // code for home page slider

            // Expanded(
            //   child: VxSwiper.builder(
            //     autoPlay: true,
            //     height: 220,
            //     enlargeCenterPage: true,
            //     itemCount: slidersList.length,
            //     itemBuilder: (context, index) {
            //       return Image.asset(
            //         slidersList[index],
            //         fit: BoxFit.fill,
            //       )
            //           .box
            //           .rounded
            //           .clip(Clip.antiAlias)
            //           .make();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}