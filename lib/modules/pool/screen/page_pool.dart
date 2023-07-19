import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/text_input.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';

class PoolPage extends StatelessWidget {
  const PoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: const CustomAppbar(appbarText: 'Tambah Kolam'),
      body: Column(
        children: [
          SizedBox(height: 32),
          TextInput(
            label: 'Nama Kolam',
            hint: 'Masukkan Nama',
          ),
          SizedBox(height: 26),
          TextInput(
            label: 'Pajang Kolam (dalam satuan meter)',
            hint: 'Masukkan Panjang',
          ),
          SizedBox(height: 26),
          TextInput(
            label: 'Pajang Kolam (dalam satuan meter)',
            hint: 'Masukkan Lebar',
          ),
          SizedBox(height: 26),
          Container(
            color: CustomColor.white,
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Foto Kolam',
                  style: CustomTextStyle.body2SemiBold.copyWith(
                    color: CustomColor.primary,
                  ),
                ),
                Divider(),
                Text(
                  'Silahkan upload Foto Kolam dengan cara menyentuh area/foto dibawah ini :',
                  style: CustomTextStyle.body2Regular.copyWith(
                    color: CustomColor.grey,
                  ),
                ),
                SizedBox(height: 8),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: CustomColor.fadedGrey),
                        color: CustomColor.fadedGrey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        'Pilih Gambar',
                        style: CustomTextStyle.body2SemiBold,
                      ),
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
