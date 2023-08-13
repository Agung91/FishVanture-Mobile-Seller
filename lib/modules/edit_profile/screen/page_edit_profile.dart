import 'package:iconly/iconly.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/auth/bloc/bloc_auth.dart';
import 'package:seller/core/auth/bloc/event.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/modules/edit_profile/bloc/bloc_edit_profile.dart';
import 'package:seller/modules/edit_profile/model/model_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocProfile = context.read<EditProfileBloc>();
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
                    return const SizedBox(
                      height: 100,
                    );
                  }
                  return SizedBox(
                    height: 276,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/bg_profile.png',
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 59,
                                backgroundColor: CustomColors.grey,
                                backgroundImage:
                                    AssetImage('assets/default_profile.png'),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                data.name ?? '-',
                                style: CustomTextStyle.body1Medium.copyWith(
                                  color: CustomColors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                data.email ?? '-',
                                style: CustomTextStyle.body2Regular.copyWith(
                                  color: CustomColors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        const _BackButton(),
                      ],
                    ),
                  );
                }),
            InkWell(
              onTap: () {
                AuthBloc().raise(EventAuthLogout());
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('LOGOUT'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 48,
      left: 24,
      child: InkWell(
        onTap: () {
          RouteBloc().pop();
        },
        child: SizedBox(
          height: 40,
          width: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white30,
              shape: BoxShape.circle,
            ),
            child: Icon(
              IconlyLight.arrow_left_2,
              size: 24,
              color: CustomColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
