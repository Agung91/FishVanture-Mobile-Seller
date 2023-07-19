import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';

class ListPoolPage extends StatelessWidget {
  const ListPoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: const CustomAppbar(appbarText: 'Kolam'),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 12),
        itemBuilder: (context, index) {
          return const _WPool();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemCount: 12,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        color: CustomColor.white,
        child: CustomButton(
          textButton: 'Tambah Kolam',
          onTap: () async {
            RouteBloc().push(RoutePool());
          },
        ),
      ),
    );
  }
}

class _WPool extends StatelessWidget {
  const _WPool({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: CustomColor.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const FadeInImage(
              height: 60,
              width: 100,
              placeholder: AssetImage('assets/load_img.png'),
              image: AssetImage('assets/ikan.png'),
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kolam 1',
                style: CustomTextStyle.body2SemiBold,
              ),
              const SizedBox(height: 2),
              Text(
                '2m x 2m',
                style: CustomTextStyle.body2Medium,
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: const SizedBox(
              height: 40,
              width: 40,
              child: Icon(
                Iconsax.trash,
                color: CustomColor.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
