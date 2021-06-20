import 'package:flutter/material.dart';

class EmptyDataScreen extends StatelessWidget {
  final String _message;

  EmptyDataScreen(this._message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _message,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
    // return Center(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.max,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       FaIcon(
    //         FontAwesomeIcons.frown,
    //         color: Colors.grey,
    //         size: 75,
    //       ),
    //       Divider(),
    //       Text(
    //         _message,
    //         style: TextStyle(
    //           color: Colors.grey,
    //           fontSize: 20.0,
    //           fontWeight: FontWeight.normal,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
