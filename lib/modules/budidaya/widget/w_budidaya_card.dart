import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

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

  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    final waktuPanen = _daysBetween(
        DateTime.now(), budidayaModel.estPanenDate ?? DateTime.now());
    // print(waktuPanen);
    // print('awal  = ${budidayaModel.dateOfSeed}');
    // print('akhir  = ${budidayaModel.estPanenDate}');
    return GestureDetector(
      onTap: () => RouteBloc().push(RouteDetailBudidaya(budidayaModel)),
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
                  placeholder: const AssetImage('assets/load_img.png'),
                  image: CachedNetworkImageProvider(budidayaModel.pool.image),
                ),
              ),
              // child: CachedNetworkImage(imageUrl: imageUrl),
            ),
            const SizedBox(height: 4),
            Text(
              budidayaModel.pool.name,
              style: CustomTextStyle.body3Regular.copyWith(
                color: CustomColors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              budidayaModel.fishSpecies.name,
              style: CustomTextStyle.body2SemiBold,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    budidayaModel.status.toUpperCase(),
                    style: CustomTextStyle.body2Medium.copyWith(
                      color: CustomColors.primary,
                    ),
                  ),
                ),
                if (budidayaModel.estPanenDate != null && waktuPanen >= 0) ...[
                  const Icon(
                    IconlyBold.time_circle,
                    size: 16,
                    color: CustomColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$waktuPanen Hari',
                    style: CustomTextStyle.body2Medium.copyWith(
                      color: CustomColors.primary,
                    ),
                  ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
