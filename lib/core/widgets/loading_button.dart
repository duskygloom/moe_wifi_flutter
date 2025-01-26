import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({
    super.key,
    required this.text,
    this.color,
    this.onTap,
    this.width,
    this.icon,
    this.borderRadius,
  });

  final String text;
  final Future<void> Function()? onTap;
  final Color? color;
  final double? width;
  final Icon? icon;
  final double? borderRadius;

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 100),
          color: widget.color ?? Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(
              color: Colors.white, width: 2, style: BorderStyle.solid)),
      child: TextButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          if (widget.onTap != null) {
            await widget.onTap!();
          }
          await Future.delayed(const Duration(milliseconds: 500));
          setState(() {
            isLoading = false;
          });
        },
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(widget.width ?? 180, 40)),
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: 20, child: CircularProgressIndicator())
            : widget.icon ?? Text(widget.text),
      ),
    );
  }
}
