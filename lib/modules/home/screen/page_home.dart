import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/auth/bloc/bloc_auth.dart';
import 'package:seller/core/auth/bloc/event.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/home/widget/w_card.dart';
import 'package:seller/modules/order/screen/page_order.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: _AppbarHome(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _WCategori(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Produk Anda',
                    style: CustomTextStyle.body2SemiBold,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Lihat Semua',
                        style: CustomTextStyle.body2SemiBold.copyWith(
                          color: CustomColor.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              height: 208,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemBuilder: (context, index) {
                  return WCard();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 8.0);
                },
                itemCount: 5,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _WCategori extends StatelessWidget {
  const _WCategori({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: CustomColor.white,
      child: Column(
        children: [
          _ItemCategori(
            text: 'Pesanan',
            subText: 'Daftar Pesanan Anda',
            iconData: IconlyBold.bag,
            onTap: () => RouteBloc().push(RouteOrder()),
          ),
          _ItemCategori(
            text: 'Pesan',
            subText: 'Pesan pelanggan Anda',
            iconData: IconlyBold.chat,
            onTap: () => RouteBloc().push(RouteListChat()),
          ),
          _ItemCategori(
            text: 'Pengaturan Produk',
            subText: 'Atur produk Anda',
            iconData: IconlyBold.setting,
            onTap: () => RouteBloc().push(RoutePond()),
            // onTap: () => AuthBloc().raise(EventAuthLogout()),
          ),
        ],
      ),
    );
  }
}

class _ItemCategori extends StatelessWidget {
  const _ItemCategori({
    Key? key,
    required this.text,
    required this.subText,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData iconData;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    center: Alignment.bottomRight,
                    radius: 3,
                    colors: [
                      CustomColor.primary,
                      CustomColor.white,
                    ],
                    tileMode: TileMode.clamp,
                  ).createShader(bounds);
                },
                child: Icon(
                  iconData,
                  size: 40,
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColor.background,
              ),
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: CustomTextStyle.body1Medium,
                ),
                SizedBox(height: 6),
                Text(
                  subText,
                  style: CustomTextStyle.body3Medium
                      .copyWith(color: CustomColor.fadedGrey),
                ),
              ],
            ),
            Spacer(),
            Visibility(
              visible: false,
              child: Container(
                padding: EdgeInsets.all(6),
                child: Text(
                  '2',
                  style: CustomTextStyle.body2Medium.copyWith(
                    color: CustomColor.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: CustomColor.red, shape: BoxShape.circle),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(
              IconlyLight.arrow_right_2,
              color: CustomColor.grey,
            )
          ],
        ),
      ),
    );
  }
}

class _AppbarHome extends StatelessWidget implements PreferredSizeWidget {
  const _AppbarHome({
    super.key,
  });

  @override
  Size get preferredSize => const Size(double.infinity, 101);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteBloc().push(RouteProfile());
      },
      child: Container(
        height: 101,
        color: CustomColor.primary,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                // Icon(IconlyLight.arrow_left),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: CustomColor.grey,
                  backgroundImage: AssetImage('assets/default_profile.png'),
                ),
                const SizedBox(width: 12.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang,',
                      style: CustomTextStyle.body3Regular
                          .copyWith(color: CustomColor.white),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Agung Nurcahyo Rosiandana',
                      style: CustomTextStyle.body1Medium
                          .copyWith(color: CustomColor.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
