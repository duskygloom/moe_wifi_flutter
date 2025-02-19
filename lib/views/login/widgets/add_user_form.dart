import 'package:flutter/material.dart';
import 'package:moe_wifi/models/local_storage.dart';
import 'package:moe_wifi/core/widgets/loading_button.dart';
import 'package:moe_wifi/core/widgets/text_input.dart';
import 'package:moe_wifi/views/login/widgets/quick_login_row.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> addUserFunction() async {
    if (!formKey.currentState!.validate()) return;
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
    var widgets = [
      LoadingButton(
        text: 'Add user',
        onTap: addUserFunction,
      ),
      const SizedBox(width: 10, height: 16),
      const QuickLoginRow(),
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
            onEnterPress: addUserFunction,
          ),
          const SizedBox(height: 10),
          TextInput(
            hintText: 'Password',
            controller: passwordController,
            isObscure: true,
            isMandatory: true,
            onEnterPress: addUserFunction,
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
