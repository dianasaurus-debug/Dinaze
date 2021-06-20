import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  final String _title;

  FormTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15.0,
      ),
    );
  }
}
