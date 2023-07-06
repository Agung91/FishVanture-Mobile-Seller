import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class WCard extends StatelessWidget {
  const WCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('hallo');
      },
      child: Container(
        padding: const EdgeInsets.all(6.0),
        width: 168,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: FadeInImage(
                height: 118,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/load_img.png'),
                image: AssetImage('assets/ikan.png'),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Rahmat Tarihoran',
              style: CustomTextStyle.body2SemiBold,
            ),
            SizedBox(height: 4),
            Text(
              'Desa Jatiadi, Kec. Gending - Probolinggo',
              style: CustomTextStyle.body3Regular.copyWith(
                color: CustomColor.grey,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  IconlyBold.time_circle,
                  size: 16,
                  color: CustomColor.primary,
                ),
                SizedBox(width: 4),
                Text(
                  '123 Hari',
                  style: CustomTextStyle.body2Medium.copyWith(
                    color: CustomColor.primary,
                  ),
                ),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: CustomColor.white,
        ),
      ),
    );
  }
}
