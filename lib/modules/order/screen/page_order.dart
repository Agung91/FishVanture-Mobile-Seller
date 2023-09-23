import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:seller/common/custom/empty_data.dart';
import 'package:seller/common/custom/format_number.dart';
import 'package:seller/common/snackbar/snackbar_popup.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/modules/order/bloc/bloc_order.dart';
import 'package:seller/modules/order/model/model_order.dart';
import 'package:seller/modules/order/model/order_status.dart';

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
                _WOrderActive(),
                _OrderComplete(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _WOrderActive extends StatelessWidget {
  const _WOrderActive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final blocOrder = context.read<OrderBloc>();
    return StreamBuilder<List<OrderModel>>(
        stream: blocOrder.orderActive.stream,
        initialData: blocOrder.orderActive.value,
        builder: (context, snapshot) {
          final listData = snapshot.data;
          if (listData == null || listData.isEmpty) {
            return EmptyData(
              label: 'Belum ada pesanan terbaru',
              onRefresh: () async => await blocOrder.order(),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => await blocOrder.order(),
            child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 12),
                itemBuilder: (context, index) {
                  return _ItemOrder(
                    orderModel: listData[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8.0);
                },
                itemCount: listData.length),
          );
        });
  }
}

class _OrderComplete extends StatelessWidget {
  const _OrderComplete({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final blocOrder = context.read<OrderBloc>();
    return StreamBuilder<List<OrderModel>>(
        stream: blocOrder.orderComplete.stream,
        initialData: blocOrder.orderComplete.value,
        builder: (context, snapshot) {
          final listData = snapshot.data;
          if (listData == null || listData.isEmpty) {
            return EmptyData(
              onRefresh: () async => await blocOrder.order(),
              label: 'Belum ada pesanan yang selesai diproses',
            );
          }
          return RefreshIndicator(
            onRefresh: () async => await blocOrder.order(),
            child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemBuilder: (context, index) {
                  return _ItemOrder(
                    orderModel: listData[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8.0);
                },
                itemCount: listData.length),
          );
        });
  }
}

class _ItemOrder extends StatelessWidget {
  const _ItemOrder({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final blocOrder = context.read<OrderBloc>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: CustomColors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderModel.code,
                style: CustomTextStyle.body2Medium.copyWith(
                  color: CustomColors.grey,
                ),
              ),
              Text(
                DateFormat('EEEE, dd MMMM yyyy', 'id')
                    // .format(orderModel.createdAt),
                    .format(orderModel.bookingDate),
                style: CustomTextStyle.body3Regular.copyWith(
                  color: CustomColors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerLeft,
            child: _StatusOrder(status: orderModel.status),
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
                  placeholder: const AssetImage('assets/load_img.png'),
                  image: CachedNetworkImageProvider(
                      orderModel.budidaya.pool.image),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderModel.user.name.toUpperCase(),
                    style: CustomTextStyle.body2SemiBold,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${orderModel.budidaya.fishSpecies.name.toUpperCase()} (${orderModel.qty} kg)',
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
                orderModel.ammout.toIdr(),
                style: CustomTextStyle.body1SemiBold,
              )),
          const SizedBox(height: 16),
          if (orderModel.status == OrderStatus.active) ...[
            CustomButton(
              isPrimary: false,
              textButton: 'Pesanan Selesai',
              onTap: () async {
                await blocOrder.orderCompleted(orderModel.id);
                snacBarPopUp(
                  message: 'Pesanan Berhasil Diselesaikan',
                  color: CustomColors.green,
                  icon: IconlyLight.tick_square,
                );
                blocOrder.order();
              },
            ),
          ]
        ],
      ),
    );
  }
}

class _StatusOrder extends StatelessWidget {
  const _StatusOrder({
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
          color: OrderStatus.statusFadedColor(status),
        ),
        child: Text(
          OrderStatus.statusInfo(status),
          style: CustomTextStyle.body3Regular.copyWith(
            color: OrderStatus.statusColor(status),
          ),
        ));
  }
}
