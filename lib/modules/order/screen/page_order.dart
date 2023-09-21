import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/modules/order/bloc/bloc_order.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: CustomAppbar(appbarText: 'Pesanan'),
        body: Column(
          children: [
            Container(
              color: CustomColors.white,
              child: TabBar(
                unselectedLabelColor: CustomColors.fadedGrey,
                labelColor: CustomColors.primary,
                tabs: [
                  Tab(
                    text: 'Berlangsung',
                  ),
                  Tab(
                    text: 'Selesai',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                WOrderActive(),
                Center(
                  child: Text('selesai'),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class WOrderActive extends StatelessWidget {
  const WOrderActive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final blocOrder = context.read<OrderBloc>();
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 12),
        itemBuilder: (context, index) {
          return ItemOrder();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8.0);
        },
        itemCount: 4);
  }
}

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final blocOrder = context.read<OrderBloc>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: CustomColors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DRM00000123',
                style: CustomTextStyle.body2Medium.copyWith(
                  color: CustomColors.grey,
                ),
              ),
              Text(
                '17 November 2022 - 16:47 WIB',
                style: CustomTextStyle.body3Regular.copyWith(
                  color: CustomColors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: StatusOrder(status: 'Sedang Proses'),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage(
                  height: 60,
                  fit: BoxFit.cover,
                  width: 80,
                  placeholder: AssetImage('assets/load_img.png'),
                  image: CachedNetworkImageProvider(
                      'https://picsum.photos/500/500?random=1'),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ikan Lele',
                    style: CustomTextStyle.body2SemiBold,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '20 kg',
                    style: CustomTextStyle.body2Regular.copyWith(
                      color: CustomColors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Rp 2.600.000',
                style: CustomTextStyle.body1SemiBold,
              )),
          const SizedBox(height: 16),
          CustomButton(
            isPrimary: false,
            textButton: 'Transaksi Selesai',
            onTap: () async {
              blocOrder.order();
            },
          ),
        ],
      ),
    );
  }
}

class StatusOrder extends StatelessWidget {
  const StatusOrder({
    Key? key,
    required this.status,
  }) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: CustomColors.fadedBlue,
        ),
        child: Text(
          status,
          style: CustomTextStyle.body3Regular.copyWith(
            color: CustomColors.primary,
          ),
        ));
  }
}
