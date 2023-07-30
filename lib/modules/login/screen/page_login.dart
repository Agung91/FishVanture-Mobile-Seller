import 'package:seller/common/widgets/button.dart';
import 'package:seller/common/widgets/text_input.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/login/bloc/bloc_login.dart';
import 'package:seller/modules/login/repo/repo_login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocLogin = LoginBLoc(LoginRepo());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Masuk',
                style: CustomTextStyle.heading4Medium,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextInput(
              sStream: blocLogin.email,
              keyboardType: TextInputType.emailAddress,
              label: 'Email',
              hint: 'Masukkan Email',
            ),
          ),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextInput(
              sStream: blocLogin.password,
              label: 'Password',
              hint: 'Masukkan Password',
              obscureText: true,
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomButton(
              textButton: 'Login',
              onTap: () async {
                await blocLogin.login();
                final snackBar = SnackBar(
                  content: Text('Berhasil Login!!!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum mempunyai akun?',
                style: CustomTextStyle.body2Regular,
              ),
              InkWell(
                onTap: () {
                  RouteBloc().push(RouteRegister());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: Text(
                    ' Daftar',
                    style: CustomTextStyle.body2SemiBold.copyWith(
                      color: CustomColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
