import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';

class WPool extends StatelessWidget {
  const WPool({
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
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/load_img.png'),
              image: CachedNetworkImageProvider(
                  'https://picsum.photos/500/500?random=1'),
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
