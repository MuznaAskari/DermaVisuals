import 'package:DermaVisuals/Components/appbar.dart';
import 'package:flutter/material.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: appbar(context),
          drawer:  drawer(context, "Doctor"),

        )
    );
  }
}
