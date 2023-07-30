import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/home/widget/w_home_card.dart';
import 'package:seller/modules/profile/bloc/bloc_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const _AppbarHome(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const _SubmisionInfo(),
            // _SubmisionInfoInReview(),
            // _SubmisionInfoRejected(),
            const SizedBox(height: 8),
            const _WCategori(),
            const SizedBox(height: 12.0),
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
                          color: CustomColors.primary,
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
                  return const WHomeCard();
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

class _SubmisionInfo extends StatelessWidget {
  const _SubmisionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          RouteBloc().push(RouteFormSubmission());
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
          color: CustomColors.yellow,
          child: Text(
            'Silakan isi formulir pengajuan terlebih dahulu agar akun dapat digunakan.',
            textAlign: TextAlign.center,
            style: CustomTextStyle.body2Regular
                .copyWith(color: CustomColors.white),
          ),
        ));
  }
}

class _SubmisionInfoInReview extends StatelessWidget {
  const _SubmisionInfoInReview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
          color: CustomColors.green,
          child: Text(
            'Saat ini, formulir pengajuan sedang dalam proses peninjauan.',
            textAlign: TextAlign.center,
            style: CustomTextStyle.body2Regular
                .copyWith(color: CustomColors.white),
          ),
        ));
  }
}

class _SubmisionInfoRejected extends StatelessWidget {
  const _SubmisionInfoRejected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
          width: double.infinity,
          color: CustomColors.red,
          child: Text(
            'Maaf, formulir pengajuan Anda ditolak ',
            textAlign: TextAlign.center,
            style: CustomTextStyle.body2Regular
                .copyWith(color: CustomColors.white),
          ),
        ));
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
      color: CustomColors.white,
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
            onTap: () => RouteBloc().push(RouteProductSetting()),
          ),
          _ItemCategori(
            text: 'Profile',
            subText: 'Atur profile Anda',
            iconData: IconlyBold.profile,
            onTap: () {},
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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.background,
              ),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return const RadialGradient(
                    center: Alignment.bottomRight,
                    radius: 3,
                    colors: [
                      CustomColors.primary,
                      CustomColors.white,
                    ],
                    tileMode: TileMode.clamp,
                  ).createShader(bounds);
                },
                child: Icon(
                  iconData,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: CustomTextStyle.body1Medium,
                ),
                const SizedBox(height: 6),
                Text(
                  subText,
                  style: CustomTextStyle.body3Medium
                      .copyWith(color: CustomColors.fadedGrey),
                ),
              ],
            ),
            const Spacer(),
            Visibility(
              visible: false,
              child: Container(
                padding: const EdgeInsets.all(6),
                child: Text(
                  '2',
                  style: CustomTextStyle.body2Medium.copyWith(
                    color: CustomColors.white,
                  ),
                ),
                decoration: const BoxDecoration(
                    color: CustomColors.red, shape: BoxShape.circle),
              ),
            ),
            const SizedBox(width: 8.0),
            const Icon(
              IconlyLight.arrow_right_2,
              color: CustomColors.grey,
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

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      content: const Text('Error message text'),
      leading: const CircleAvatar(child: Icon(Icons.delete)),
      actions: [
        TextButton(
          child: const Text('ACTION 1'),
          onPressed: () {},
        ),
        TextButton(
          child: const Text('ACTION 2'),
          onPressed: () {},
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return InkWell(
      onTap: () {
        RouteBloc().push(RouteEditProfile());
      },
      child: Container(
        height: 101,
        color: CustomColors.primary,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                // Icon(IconlyLight.arrow_left),
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: CustomColors.grey,
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
                          .copyWith(color: CustomColors.white),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'Agung Nurcahyo Rosiandana',
                      style: CustomTextStyle.body1Medium
                          .copyWith(color: CustomColors.white),
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
