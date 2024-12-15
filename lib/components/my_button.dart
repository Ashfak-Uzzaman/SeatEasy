import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isEnabled; // Added to control the button state (enabled/disabled)

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.isEnabled, // Default is enabled
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      //focusColor: Colors.grey[600],
      //splashColor: Colors.grey[600],
      //hoverColor: Colors.grey[600],
      highlightColor: Colors.grey[600],

      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.3, // Reduce opacity when disabled
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              text, // how to use perameterizes string as message here?
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
