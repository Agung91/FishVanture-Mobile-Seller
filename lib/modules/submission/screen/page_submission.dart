import 'package:flutter/material.dart';
import 'package:location/location.dart';
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
import 'package:seller/modules/pool/widget/w_pool.dart';
import 'package:seller/modules/submission/bloc/bloc_submission.dart';
import 'package:seller/modules/submission/repo/repo_submission.dart';
import 'package:seller/modules/submission/widget/w_submission_pool.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final addressBloc = AddressBloc(AddressHttpRepo());
    // final pondBloc = context.read<PondBloc>();
    final submissionBloc = SubmissionBloc(
      SubmissionHttpRepo(),
      AddressHttpRepo(),
    );
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: const CustomAppbar(appbarText: 'Pengajuan Budidaya'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                sStream: submissionBloc.name,
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
                listItem: submissionBloc.countrys,
                selected: submissionBloc.country,
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Provinsi',
                hint: 'Pilih Provinsi',
                listItem: submissionBloc.provinces,
                selected: submissionBloc.province,
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Kabupaten/Kota',
                hint: 'Pilih Kabupaten/Kota',
                listItem: submissionBloc.citys,
                selected: submissionBloc.city,
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: StreamDropdown(
                label: 'Kecamatan',
                hint: 'Pilih Kecamatan',
                listItem: submissionBloc.districts,
                selected: submissionBloc.district,
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                sStream: submissionBloc.detailAddres,
                label: 'Detail Alamat',
                hint: 'Masukkan Detail Alamat',
              ),
            ),
            const SizedBox(height: 26),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                  'Catatan : Tekan "Ambil Lokasi" untuk mengambil lokasi saat ini. Pastikan Anda berada di area yang akan didaftarkan.'),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: StreamBuilder<LocationData?>(
                  stream: submissionBloc.initialKoordinat.stream,
                  initialData: submissionBloc.initialKoordinat.value,
                  builder: (context, snapshot) {
                    final dataKoordinat = snapshot.data;
                    if (dataKoordinat == null) {
                      return TextButton(
                        onPressed: () async {
                          Location location = Location();

                          // late bool _serviceEnabled;
                          // late PermissionStatus _permissionGranted;
                          // late LocationData _locationData;

                          var _serviceEnabled = await location.serviceEnabled();
                          if (!_serviceEnabled) {
                            _serviceEnabled = await location.requestService();
                            if (!_serviceEnabled) {
                              return;
                            }
                          }

                          var _permissionGranted =
                              await location.hasPermission();
                          if (_permissionGranted == PermissionStatus.denied) {
                            _permissionGranted =
                                await location.requestPermission();
                            if (_permissionGranted !=
                                PermissionStatus.granted) {
                              return;
                            }
                          }

                          var _locationData = await location.getLocation();
                          submissionBloc.initialKoordinat.add(_locationData);

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //         'latitude = ${_locationData.latitude}, longitude = ${_locationData.longitude}'),
                          //     action: SnackBarAction(
                          //       label: 'Salin',
                          //       onPressed: () {
                          //         // Clipboard.setData(ClipboardData(
                          //         //     text: '${_locationData.latitude} ${_locationData.longitude}'));
                          //         Clipboard.getData(
                          //             '${_locationData.latitude} ${_locationData.longitude}');
                          //       },
                          //     ),
                          //   ),
                          // );
                          print(_locationData);
                          print(_locationData.accuracy);
                          print(_locationData.altitude);
                        },
                        child: const Text('Ambil Lokasi.'),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColor.fadedGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Koordinat: ${dataKoordinat.latitude}, ${dataKoordinat.longitude}',
                      ),
                    );
                  }),
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
                          RouteBloc().push(RoutePool(submissionBloc));
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
            _WUploadFile(),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                textButton: 'Submit',
                onTap: () async {
                  // pondBloc.getPond();
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

class _WUploadFile extends StatelessWidget {
  const _WUploadFile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
