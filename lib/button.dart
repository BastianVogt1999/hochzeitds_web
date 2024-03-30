import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool buttonPressed = false;
  Color foregroundColor = Colors.blueGrey;
  Color backgroundColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        width: 150,
        height: 30,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              buttonPressed = !buttonPressed;
            });
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: buttonPressed ? foregroundColor : backgroundColor,
            backgroundColor: buttonPressed ? backgroundColor : foregroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: const Text("Kategorie 1"),
        ));
  }
}
