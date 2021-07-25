import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final double size;
  final Color color;
  final double width;

  Loading({
    this.size = 35.0,
    this.color = Constant.bwiGreenColor,
    this.width = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRing(
        color: color,
        lineWidth: width,
        size: size,
      ),
    );
  }
}
