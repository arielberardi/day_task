import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  final String text;

  const DividerText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: Theme.of(context).textTheme.labelLarge?.color,
          ),
        ),
        const SizedBox(width: 5.0),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Theme.of(context).textTheme.labelLarge?.color,
          ),
        ),
      ],
    );
  }
}
