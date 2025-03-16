import 'package:flutter/material.dart';
import 'package:moe_wifi/models/local_storage.dart';
import 'package:moe_wifi/core/widgets/loading_button.dart';
import 'package:moe_wifi/core/widgets/text_input.dart';
import 'package:moe_wifi/views/login/widgets/login_butttons.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void addUserFunction() {
    LocalStorage.putPassword(
      phoneNumber: phoneController.text,
      password: passwordController.text,
    );
    LocalStorage.putConfig(
      config: 'currentUser',
      value: phoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final passwordNode = FocusNode();

    final widgets = [
      LoadingButton(
        text: 'Add user',
        onTap: () async {
          if (formKey.currentState!.validate()) {
            addUserFunction();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Added user: ${phoneController.text}'),
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
      ),
      const SizedBox(width: 10, height: 16),
      const LoginButtons(),
    ];

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            hintText: 'Phone number',
            controller: phoneController,
            isPhone: true,
            isFocused: true,
            isMandatory: true,
            action: TextInputAction.next,
            onEnterPress: () async {
              passwordNode.requestFocus();
            },
          ),
          const SizedBox(height: 10),
          TextInput(
            hintText: 'Password',
            controller: passwordController,
            isObscure: true,
            isMandatory: true,
            focusNode: passwordNode,
            action: TextInputAction.done,
            onEnterPress: () async {
              if (formKey.currentState!.validate()) {
                addUserFunction();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Added user: ${phoneController.text}'),
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
          ),
          const SizedBox(height: 20),
          MediaQuery.sizeOf(context).width > 400
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widgets,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widgets,
                ),
        ],
      ),
    );
  }
}
