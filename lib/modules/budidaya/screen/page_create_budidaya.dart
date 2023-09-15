import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sstream/sstream.dart';

import 'package:seller/common/custom/custom_date_picker.dart';
import 'package:seller/common/snackbar/snackbar_popup.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/common/widgets/dropdown/stream_dropdown.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/modules/budidaya/bloc/bloc_budidaya.dart';
import 'package:seller/modules/fish/bloc/bloc_fish.dart';
import 'package:seller/modules/pool/bloc/bloc_pool.dart';

class CreateBudidayaPage extends StatelessWidget {
  const CreateBudidayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocBudidaya = context.read<BudidayaBloc>();
    final blocFish = context.read<FishBloc>();
    final blocPool = context.read<PoolBloc>();
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: CustomAppbar(
        appbarText: 'Tambah Budidaya',
        onBack: () => blocBudidaya.makeEmpty(),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: StreamDropdown(
              label: 'Pilih Kolam',
              listItem: blocPool.listPool,
              selected: blocBudidaya.pool,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: StreamDropdown(
              label: 'Pilih Ikan',
              listItem: blocFish.listFish,
              selected: blocBudidaya.fish,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DatePicker(sStream: blocBudidaya.date),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: Container(
        color: CustomColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: CustomButton(
          textButton: 'Submit',
          onTap: () async {
            await blocBudidaya.createBudidaya().then((value) {
              blocBudidaya.getListBudidaya();
              snacBarPopUp(
                  color: CustomColors.green,
                  icon: IconlyBold.tick_square,
                  message: 'Berhasil membuat budidaya');
            });
            RouteBloc().pop();
          },
        ),
      ),
    );
  }
}
