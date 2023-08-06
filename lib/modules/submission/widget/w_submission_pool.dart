import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/modules/pool/model/model_pool.dart';
import 'package:seller/modules/submission/bloc/bloc_submission.dart';

class WSubmissionPool extends StatelessWidget {
  const WSubmissionPool({
    Key? key,
    required this.pool,
  }) : super(key: key);

  final PoolModel pool;

  @override
  Widget build(BuildContext context) {
    final submissionBloc = context.read<SubmissionBloc>();
    return Container(
      width: 200,
      // height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: CustomColors.white,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: FadeInImage(
              height: 120,
              width: 200,
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/load_img.png'),
              image: CachedNetworkImageProvider(pool.image),
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
                      pool.name,
                      style: CustomTextStyle.body2SemiBold,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${pool.long}m x ${pool.wide}m',
                      style: CustomTextStyle.body2Medium,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    submissionBloc.deletePool(pool.name);
                  },
                  child: const SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Iconsax.trash,
                      color: CustomColors.red,
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
