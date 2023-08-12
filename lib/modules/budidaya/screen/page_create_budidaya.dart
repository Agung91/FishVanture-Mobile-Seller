import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/modules/budidaya/bloc/bloc_budidaya.dart';
import 'package:seller/modules/pool/bloc/bloc_pool.dart';

class CreateBudidayaPage extends StatelessWidget {
  const CreateBudidayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocBudidaya = context.read<BudidayaBloc>();
    final blocFish = context.read<BudidayaBloc>();
    final blocPool = context.read<PoolBloc>();
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const CustomAppbar(appbarText: 'Mulai Budidaya'),
      body: Column(
        children: [],
      ),
    );
  }
}
