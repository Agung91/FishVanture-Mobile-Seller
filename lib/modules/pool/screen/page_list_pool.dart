import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:seller/common/custom/empty_data.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/modules/pond/bloc/bloc_pond.dart';
import 'package:seller/modules/pond/model/pond_id.dart';
import 'package:seller/modules/pool/bloc/bloc_pool.dart';
import 'package:seller/modules/pool/model/model_pool.dart';
import 'package:seller/modules/pool/widget/w_pool.dart';

class ListPoolPage extends StatelessWidget {
  const ListPoolPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocPool = context.read<PoolBloc>();
    // final blocPond = PondBloc();
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const CustomAppbar(appbarText: 'Kolam'),
      body: StreamBuilder<List<PoolModel>>(
          stream: blocPool.listPool.stream,
          initialData: blocPool.listPool.value,
          builder: (context, snapshot) {
            final listData = snapshot.data;
            if (listData == null || listData.isEmpty) {
              return EmptyData(
                label: 'Belum ada kolam',
                onRefresh: () => blocPool.getPools(),
              );
            }
            return RefreshIndicator(
              onRefresh: () => blocPool.getPools(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                itemBuilder: (context, index) {
                  return WPool(
                    poolModel: listData[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemCount: listData.length,
              ),
            );
          }),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      //   color: CustomColors.white,
      //   child: CustomButton(
      //     textButton: 'Tambah Kolam',
      //     onTap: () async {
      //       RouteBloc().push(RoutePool());
      //     },
      //   ),
      // ),
    );
  }
}
