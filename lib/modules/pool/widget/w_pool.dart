import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/modules/pool/model/model_pool.dart';

class WPool extends StatelessWidget {
  const WPool({
    Key? key,
    required this.poolModel,
  }) : super(key: key);

  final PoolModel poolModel;

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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage(
              height: 60,
              width: 100,
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/load_img.png'),
              image: CachedNetworkImageProvider(poolModel.image),
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                poolModel.name,
                style: CustomTextStyle.body2SemiBold,
              ),
              const SizedBox(height: 4),
              Text(
                '${poolModel.long}m x ${poolModel.wide}m',
                style: CustomTextStyle.body2Medium,
              ),
            ],
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
