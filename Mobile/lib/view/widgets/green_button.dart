import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';

class GreenButton extends StatelessWidget {
  final String text;
  final Function() onPressedFunction;

  GreenButton({required this.text, required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Constant.bwiGreenColor,
        padding: EdgeInsets.symmetric(vertical: 10.0),
      ),
      onPressed: onPressedFunction,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17.0,
        ),
      ),
    );
  }
}
