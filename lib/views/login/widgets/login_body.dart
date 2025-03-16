import 'package:flutter/material.dart';
import 'package:moe_wifi/core/theme.dart';
import 'package:moe_wifi/views/login/widgets/user_form.dart';

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
          child: UserForm(),
        ),
        const SizedBox(height: 40),
      ],
    );

    final appWidth = MediaQuery.sizeOf(context).width;
    final appHeight = MediaQuery.sizeOf(context).height;

    if (appWidth <= CustomTheme.mobileWidth && appHeight < 485) {
      return SingleChildScrollView(child: content);
    } else if (appHeight < 405) {
      return SingleChildScrollView(child: content);
    } else {
      return content;
    }
  }
}
