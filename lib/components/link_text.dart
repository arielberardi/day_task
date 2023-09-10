import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final TextAlign textAlign;
  final TextStyle? style;

  const LinkText(
    this.text, {
    super.key,
    required this.onTap,
    this.textAlign = TextAlign.left,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign,
        style: style ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
      ),
    );
  }
}
