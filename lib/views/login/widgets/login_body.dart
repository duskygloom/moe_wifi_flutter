import 'package:flutter/material.dart';
import 'package:moe_wifi_gui/core/theme.dart';
import 'package:moe_wifi_gui/views/login/widgets/add_user_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    var content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            'MoE Wi-Fi',
            style: CustomTheme.titleTextTheme.copyWith(fontSize: 40),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AddUserForm(),
        ),
        const SizedBox(height: 40),
      ],
    );
    return MediaQuery.sizeOf(context).height < 600 ? SingleChildScrollView(
      child: content,
    ) : content;
  }
}
