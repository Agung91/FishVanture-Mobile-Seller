import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:seller/common/custom/format_number.dart';
import 'package:seller/common/snackbar/snackbar_popup.dart';

import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/budidaya/model/model_budidaya.dart';

class DetailBudidayaPage extends StatelessWidget {
  const DetailBudidayaPage({
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
        budidayaModel.dateOfSeed, budidayaModel.estPanenDate ?? DateTime.now());
    final price = budidayaModel.priceList;
    if (budidayaModel.priceList != null) {
      price?.sort(
        (a, b) => a.limit - b.limit,
      );
    }
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const CustomAppbar(appbarText: 'Detail Budidaya'),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/load_img.png'),
                  image: CachedNetworkImageProvider(budidayaModel.pool.image),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 60,
                      width: 100,
                      child: Icon(
                        IconlyBold.info_square,
                        color: CustomColors.red,
                        size: 60,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CustomColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          budidayaModel.pool.name,
                          style: CustomTextStyle.body2Medium
                              .copyWith(color: CustomColors.grey),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            budidayaModel.fishSpecies.name.toUpperCase(),
                            style: CustomTextStyle.body1Medium,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      budidayaModel.status.toUpperCase(),
                      style: CustomTextStyle.body2Medium.copyWith(
                        color: CustomColors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Iconsax.calendar_1,
                      color: CustomColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('EEEE, dd MMMM yyyy', 'id')
                          .format(budidayaModel.dateOfSeed),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      IconlyLight.time_circle,
                      color: CustomColors.primary,
                    ),
                    const SizedBox(width: 4),
                    if (budidayaModel.estPanenDate != null) ...[
                      Text('$waktuPanen Hari'),
                    ] else ...[
                      const Text('-'),
                    ]
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  price?.first.price.toIdr() ?? '-' '/Kg',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: CustomColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: (budidayaModel.estPanenDate == null)
            ? CustomButton(
                textButton: 'Tambah Estimasi Panen',
                onTap: () async {
                  RouteBloc().push(RouteCreateProduct(budidayaModel.id));
                },
              )
            : CustomButton(
                isPrimary: false,
                textButton: 'Perbarui Estimasi Panen',
                onTap: () async {
                  RouteBloc().push(RouteUpdateProduct(budidayaModel));
                },
              ),
      ),
    );
  }
}
