import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:get/get.dart';

class BoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          physics: NeverScrollableScrollPhysics(),
          children: [
            Image.asset(
              'images/bwi-logo-2.png',
            ),
            Divider(),
            GreenButton(
              text: "DAFTAR",
              onPressedFunction: () => Get.toNamed('/register'),
            ),
            Divider(),
            GreenButton(
              text: "MASUK",
              onPressedFunction: () => Get.toNamed('/login'),
            ),
          ],
        ),
      ),
    );
  }
}
