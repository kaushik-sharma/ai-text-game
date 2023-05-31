import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final double textSize;
  final VoidCallback onTap;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.textSize,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const StadiumBorder(),
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(
            side: BorderSide(
              color: Colors.white,
            ),
          ),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: foregroundColor,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}
