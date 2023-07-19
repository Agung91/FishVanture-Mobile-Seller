import 'package:flutter/material.dart';

import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/common/widgets/dropdown/stream_dropdown.dart';
import 'package:seller/common/widgets/text_input.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/modules/address/bloc/bloc_address.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addressBloc = AddressBloc();
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: CustomAppbar(appbarText: 'Pengajuan Budidaya'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                label: 'Pemilik Budidaya',
                hint: 'Masukkan Nama',
              ),
            ),
            SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Negara',
                hint: 'Pilih Negara',
                listItem: addressBloc.countrys,
                selected: addressBloc.country,
              ),
            ),
            SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Provinsi',
                hint: 'Pilih Provinsi',
                listItem: addressBloc.provinces,
                selected: addressBloc.province,
              ),
            ),
            SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Kabupaten/Kota',
                hint: 'Pilih Kabupaten/Kota',
                listItem: addressBloc.citys,
                selected: addressBloc.city,
              ),
            ),
            SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Kecamatan',
                hint: 'Pilih Kecamatan',
                listItem: addressBloc.districts,
                selected: addressBloc.district,
              ),
            ),
            SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                label: 'Detail Alamat',
                hint: 'Masukkan Detail Alamat',
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        color: CustomColor.white,
        child: CustomButton(
          textButton: 'Submit',
          onTap: () async {},
        ),
      ),
    );
  }
}
