import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:iconly/iconly.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _CustomChatAppbar(appbarText: 'Nama Orang'),
    );
  }
}

class _CustomChatAppbar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomChatAppbar({
    Key? key,
    required this.appbarText,
  }) : super(key: key);

  final String appbarText;

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 88);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      color: CustomColor.primary,
      height: 88,
      child: SafeArea(
        child: Row(
          children: [
            InkWell(
              onTap: () {
                RouteBloc().pop();
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  // color: Colors.amber,
                  child: const Icon(
                    IconlyLight.arrow_left,
                    color: CustomColor.white,
                  )),
            ),
            const SizedBox(width: 4),
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/default_profile.png'),
            ),
            const SizedBox(width: 8),
            Text(
              appbarText,
              style: CustomTextStyle.body1Medium.copyWith(
                color: CustomColor.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
