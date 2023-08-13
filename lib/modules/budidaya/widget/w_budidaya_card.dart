import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/budidaya/model/model_budidaya.dart';

class WBudidayaCard extends StatelessWidget {
  const WBudidayaCard({
    Key? key,
    required this.budidayaModel,
  }) : super(key: key);

  final BudidayaModel budidayaModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => RouteBloc().push(RouteDetailBudidaya()),
      onTap: () => RouteBloc().push(RouteCreateProduct(budidayaModel.id)),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        width: 168,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: CustomColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/load_img.png'),
                  image: CachedNetworkImageProvider(
                      'https://picsum.photos/500/500?random='),
                ),
              ),
              // child: CachedNetworkImage(imageUrl: imageUrl),
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
                color: CustomColors.grey,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  IconlyBold.time_circle,
                  size: 16,
                  color: CustomColors.primary,
                ),
                SizedBox(width: 4),
                Text(
                  '123 Hari',
                  style: CustomTextStyle.body2Medium.copyWith(
                    color: CustomColors.primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
