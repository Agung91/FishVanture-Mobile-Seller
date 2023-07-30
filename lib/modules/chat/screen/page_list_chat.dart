import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';

class ListChatPage extends StatelessWidget {
  const ListChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.background,
        appBar: const CustomAppbar(appbarText: 'Pesan'),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return _WChat();
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 0,
              thickness: 0.5,
              color: CustomColors.fadedGrey,
            );
          },
          itemCount: 12,
        ));
  }
}

class _WChat extends StatelessWidget {
  const _WChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteBloc().push(RouteChat());
      },
      child: Container(
        color: CustomColors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/default_profile.png'),
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Joko Purnomo',
                  style: CustomTextStyle.body2Medium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Selamat siang, iya masih ada',
                  style: CustomTextStyle.body3Regular,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
