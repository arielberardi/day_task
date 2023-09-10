import 'package:flutter/material.dart';

class ButtonAuth extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final Function()? onTap;

  const ButtonAuth({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.width = 80,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 2.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Image.asset(imagePath),
      ),
    );
  }
}
