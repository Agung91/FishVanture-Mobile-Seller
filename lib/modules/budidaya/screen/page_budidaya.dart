import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:seller/common/custom/empty_data.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/budidaya/bloc/bloc_budidaya.dart';
import 'package:seller/modules/budidaya/model/model_budidaya.dart';
import 'package:seller/modules/budidaya/widget/w_budidaya_card.dart';
import 'package:seller/modules/pond/bloc/bloc_pond.dart';

class BudidayaPage extends StatelessWidget {
  const BudidayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocBudidaya = context.read<BudidayaBloc>();
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const CustomAppbar(appbarText: 'Budidaya'),
      body: StreamBuilder<List<BudidayaModel>>(
          stream: blocBudidaya.listBudidaya.stream,
          initialData: blocBudidaya.listBudidaya.value,
          builder: (context, snapshot) {
            final listData = snapshot.data;
            if (listData == null || listData.isEmpty) {
              return EmptyData(
                label: 'Belum ada budidaya',
                onRefresh: () => blocBudidaya.getListBudidaya(),
              );
            }
            return RefreshIndicator(
              onRefresh: () => blocBudidaya.getListBudidaya(),
              child: MasonryGridView.builder(
                physics: const BouncingScrollPhysics(),
                // controller: _controller,
                padding: const EdgeInsets.all(8),
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemBuilder: (context, index) {
                  return WBudidayaCard(
                    budidayaModel: listData[index],
                  );
                },
                itemCount: listData.length,
              ),
            );
          }),
      bottomNavigationBar: Container(
        color: CustomColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: CustomButton(
          textButton: 'Tambah Budidaya',
          onTap: () async => RouteBloc().push(RouteCreateBudidaya()),
        ),
      ),
    );
  }
}
