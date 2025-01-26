import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    this.onTap
  });

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: Colors.white,
          width: 2,
          style: BorderStyle.solid
        )
      ),
      child: TextButton(
        onPressed: onTap,
        style: const ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(200, 40)),
        ),
        child: Text(text)
      ),
    );
  }
}
