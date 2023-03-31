import 'package:flutter/material.dart';

class SudokuTile extends StatelessWidget {
  @required
  final int value;
  @required
  final Color c;

  const SudokuTile({Key key, this.value, this.c}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Container(
        alignment: Alignment.center,
        color: c,
        child: Text(
          value==0?" ":value.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}