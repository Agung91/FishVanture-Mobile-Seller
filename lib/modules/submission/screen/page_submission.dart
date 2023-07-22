import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/common/widgets/dropdown/stream_dropdown.dart';
import 'package:seller/common/widgets/text_input.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/address/bloc/bloc_address.dart';
import 'package:seller/modules/address/repo/repo_address.dart';
import 'package:seller/modules/pond/bloc/bloc_pond.dart';
import 'package:seller/modules/submission/widget/w_submission_pool.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addressBloc = AddressBloc(AddressHttpRepo());
    final pondBloc = context.read<PondBloc>();
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: const CustomAppbar(appbarText: 'Pengajuan Budidaya'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                label: 'Pemilik Budidaya',
                hint: 'Masukkan Nama',
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Negara',
                hint: 'Pilih Negara',
                listItem: addressBloc.countrys,
                selected: addressBloc.country,
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Provinsi',
                hint: 'Pilih Provinsi',
                listItem: addressBloc.provinces,
                selected: addressBloc.province,
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Kabupaten/Kota',
                hint: 'Pilih Kabupaten/Kota',
                listItem: addressBloc.citys,
                selected: addressBloc.city,
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Kecamatan',
                hint: 'Pilih Kecamatan',
                listItem: addressBloc.districts,
                selected: addressBloc.district,
              ),
            ),
            const SizedBox(height: 26),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                label: 'Detail Alamat',
                hint: 'Masukkan Detail Alamat',
              ),
            ),
            const SizedBox(height: 26),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'List Kolam',
                      style: CustomTextStyle.body2SemiBold,
                    ),
                    TextButton(
                        onPressed: () {
                          RouteBloc().push(RoutePool());
                        },
                        child: Text(
                          'Tambah Kolam',
                          style: CustomTextStyle.body2Medium.copyWith(
                            color: CustomColor.primary,
                          ),
                        ))
                  ],
                )),
            const SizedBox(height: 4),
            SizedBox(
              height: 180,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return WSubmissionPool();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 8);
                },
                itemCount: 8,
              ),
            ),
            const SizedBox(height: 26),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              decoration: BoxDecoration(
                color: CustomColor.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jelalahi File',
                          style: CustomTextStyle.body1SemiBold,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Mohon untuk mengunggah file dengan ukuran kurang dari 2 MB',
                          style: CustomTextStyle.body2Regular,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: CustomColor.primary,
                      ),
                      child: Text(
                        'Upload',
                        style: CustomTextStyle.body1Medium
                            .copyWith(color: CustomColor.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                textButton: 'Submit',
                onTap: () async {
                  pondBloc.getPond();
                  // RouteBloc().pop();
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(
      //     horizontal: 24,
      //     vertical: 16,
      //   ),
      //   color: CustomColor.white,
      //   child: CustomButton(
      //     textButton: 'Submit',
      //     onTap: () async {},
      //   ),
      // ),
    );
  }
}
