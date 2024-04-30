import 'package:flutter/material.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Enter a number',
        border: OutlineInputBorder(),
      ),
    );
  }
}
