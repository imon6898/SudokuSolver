import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Sudoku Solver",
      style: TextStyle(
        fontFamily: "Sofia-Pro",
        color: Color(0xffB4BFC6),
        fontSize: 32,
      ),
    );
  }
}
