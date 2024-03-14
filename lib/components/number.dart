import 'package:flutter/material.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter a number',
        border: OutlineInputBorder(),
      ),
    );
  }
}
