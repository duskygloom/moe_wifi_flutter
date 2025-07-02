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
    this.onTap,
    this.onTapOutside,
    this.onChanged,
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
  final Future<void> Function()? onTap;
  final Future<void> Function()? onTapOutside;
  final Future<void> Function(String value)? onChanged;

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
          if (onEnterPress != null) await onEnterPress!();
        },
        onTap: onTap,
        onTapOutside: (_) async {
          if (onTapOutside != null) await onTapOutside!();
        },
        onChanged: onChanged,
        obscureText: isObscure,
        autofocus: isFocused,
        keyboardType: isPhone ? TextInputType.phone : null,
        textInputAction: action,
        focusNode: focusNode,
      ),
    );
  }
}
