import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';

class WSubmissionPool extends StatelessWidget {
  const WSubmissionPool({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: CustomColor.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const FadeInImage(
              // height: 120,
              // width: 200,
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/load_img.png'),
              image: AssetImage('assets/ikan.png'),
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                InkWell(
                  onTap: () {},
                  child: const SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Iconsax.trash,
                      color: CustomColor.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
