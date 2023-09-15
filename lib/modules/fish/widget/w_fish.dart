import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/modules/fish/model/model_fish.dart';

class WFish extends StatelessWidget {
  const WFish({
    Key? key,
    required this.fishModel,
  }) : super(key: key);

  final FishModel fishModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: CustomColors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      child: Row(
        children: [
          Text(
            fishModel.name,
            style: CustomTextStyle.body2SemiBold,
          ),
          Text(
            ' - ${fishModel.asal}',
            style: CustomTextStyle.body2Medium,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
          // const Spacer(),
          // InkWell(
          //   onTap: () {},
          //   child: const SizedBox(
          //     height: 40,
          //     width: 40,
          //     child: Icon(
          //       Iconsax.trash,
          //       color: CustomColors.red,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
