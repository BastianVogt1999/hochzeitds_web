import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class PopoverExample extends StatelessWidget {
  const PopoverExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: 80,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
          ),
          child: GestureDetector(
            child: const Center(child: Text('Click Me')),
            onTap: () {
              showPopover(
                context: context,
                bodyBuilder: (context) => Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text("Lorem Ipsum"),
                ),
                direction: PopoverDirection.left,
                width: 200,
                height: 50,
                arrowHeight: 15,
                arrowWidth: 30,
              );
            },
          ),
        ),
      )),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: GestureDetector(
        child: const Center(child: Text('Click Me')),
        onTap: () {
          showPopover(
            context: context,
            bodyBuilder: (context) => Container(
              padding: const EdgeInsets.all(10),
              child: const Text("Lorem Ipsum"),
            ),
            direction: PopoverDirection.left,
            width: 200,
            height: 50,
            arrowHeight: 15,
            arrowWidth: 30,
          );
        },
      ),
    );
  }
}
