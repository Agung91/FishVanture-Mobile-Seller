import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller/common/custom/empty_data.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/common/widgets/text_input.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/modules/fish/bloc/bloc_fish.dart';
import 'package:seller/modules/fish/model/model_fish.dart';
import 'package:seller/modules/fish/widget/w_fish.dart';

class CreateFishPage extends StatelessWidget {
  const CreateFishPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocFish = context.read<FishBloc>();
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: const CustomAppbar(appbarText: 'Tambah Jenis Ikan'),
      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: TextInput(
              sStream: blocFish.name,
              label: 'Nama Ikan',
              hint: 'Nama Ikan',
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: TextInput(
              sStream: blocFish.from,
              label: 'Asal Ikan',
              hint: 'Asal Ikan',
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: CustomColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: CustomButton(
          textButton: 'Tambah',
          onTap: () async {
            await blocFish.createFish();
            blocFish.getFishes();
            RouteBloc().pop();
          },
        ),
      ),
    );
  }
}
