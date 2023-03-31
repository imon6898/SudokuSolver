import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.undo,
            size: 25,
            color: Color(0xff8E8E8E),
          ),
          SizedBox(height: 2),
          Text(
            "Reset",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xffB7B7B7),
            ),
          )
        ],
      ),
    );
  }
}
