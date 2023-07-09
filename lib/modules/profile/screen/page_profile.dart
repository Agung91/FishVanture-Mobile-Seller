import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/auth/bloc/bloc_auth.dart';
import 'package:seller/core/auth/bloc/event.dart';
import 'package:seller/modules/profile/bloc/bloc_profile.dart';
import 'package:seller/modules/profile/model/model_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocProfile = context.read<ProfileBloc>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<ProfileModel?>(
                stream: blocProfile.profile.stream,
                initialData: blocProfile.profile.value,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data == null) {
                    return const SizedBox();
                  }
                  return SizedBox(
                    height: 276,
                    child: Stack(
                      children: [
                        Image.asset('assets/bg_profile.png'),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 59,
                                backgroundColor: CustomColor.grey,
                                backgroundImage:
                                    AssetImage('assets/default_profile.png'),
                              ),
                              SizedBox(height: 14),
                              Text(
                                data.name ?? '-',
                                style: CustomTextStyle.body1Medium.copyWith(
                                  color: CustomColor.white,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                data.email ?? '-',
                                style: CustomTextStyle.body2Regular.copyWith(
                                  color: CustomColor.white,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            InkWell(
              onTap: () {
                AuthBloc().raise(EventAuthLogout());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('LOGOUT'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
