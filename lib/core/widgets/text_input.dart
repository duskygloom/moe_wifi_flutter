import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.isPhone = false,
    this.isObscure = false,
    this.isFocused = false,
    this.isMandatory = false,
    this.onEnterPress,
    this.action,
    this.focusNode,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final bool isPhone;
  final bool isFocused;
  final bool isObscure;
  final bool isMandatory;
  final TextInputAction? action;
  final FocusNode? focusNode;
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
          labelText: labelText,
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
        textInputAction: action,
        focusNode: focusNode,
      ),
    );
  }
}
