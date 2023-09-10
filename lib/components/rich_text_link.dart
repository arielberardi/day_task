import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextLink extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final String linkText;
  final TextStyle? linkStyle;
  final Function()? onTap;

  const RichTextLink({
    super.key,
    this.text,
    this.textStyle,
    required this.linkText,
    this.linkStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? defaultTextStyle = Theme.of(context).textTheme.bodySmall;
    TextStyle? defaultLinkStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            );

    return ExcludeSemantics(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: textStyle ?? defaultTextStyle,
            ),
            TextSpan(
              text: linkText,
              style: linkStyle ?? defaultLinkStyle,
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
