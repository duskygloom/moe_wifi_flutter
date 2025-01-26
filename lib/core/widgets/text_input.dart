import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPhone = false,
    this.isObscure = false,
    this.isFocused = false,
    this.isMandatory = false,
    this.onEnterPress,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPhone;
  final bool isFocused;
  final bool isObscure;
  final bool isMandatory;
  final Future<void> Function()? onEnterPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width > 600
          ? 600
          : MediaQuery.sizeOf(context).width,
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).inputDecorationTheme.hintStyle,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        validator: isMandatory
            ? (value) {
                if (value == '') return 'Field is empty.';
                return null;
              }
            : null,
        onEditingComplete: () async {
          if (onEnterPress != null) {
            await onEnterPress!();
          }
        },
        obscureText: isObscure,
        autofocus: isFocused,
        keyboardType: isPhone ? TextInputType.phone : null,
      ),
    );
  }
}
