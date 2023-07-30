import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import 'package:seller/common/image_picker/bloc_upload_image.dart';
import 'package:seller/common/image_picker/repo_upload_image.dart';
import 'package:seller/common/snackbar/snackbar_popup.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/common/widgets/text_input.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/modules/submission/bloc/bloc_submission.dart';

class PoolPage extends StatelessWidget {
  const PoolPage({
    Key? key,
    required this.submissionBloc,
  }) : super(key: key);

  final SubmissionBloc submissionBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: const CustomAppbar(appbarText: 'Tambah Kolam'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                sStream: submissionBloc.poolName,
                label: 'Nama Kolam',
                hint: 'Masukkan Nama',
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                sStream: submissionBloc.poolLength,
                label: 'Panjang Kolam (dalam satuan meter)',
                keyboardType: TextInputType.number,
                hint: 'Masukkan Panjang',
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextInput(
                sStream: submissionBloc.poolWidth,
                keyboardType: TextInputType.number,
                label: 'Lebar Kolam (dalam satuan meter)',
                hint: 'Masukkan Lebar',
              ),
            ),
            const SizedBox(height: 26),
            _WPhoto(submissionBloc: submissionBloc),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomButton(
                textButton: 'Tambah',
                onTap: () async {
                  submissionBloc.addPool();
                  RouteBloc().pop();
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _WPhoto extends StatelessWidget {
  const _WPhoto({
    Key? key,
    required this.submissionBloc,
  }) : super(key: key);
  final SubmissionBloc submissionBloc;

  @override
  Widget build(BuildContext context) {
    final blocImage = ImageUploaderBloc(UploadImageHttpRepo());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: CustomColor.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foto Kolam',
            style: CustomTextStyle.body2SemiBold.copyWith(
              color: CustomColor.primary,
            ),
          ),
          const Divider(),
          Text(
            'Silahkan upload Foto Kolam dengan cara menyentuh area/foto dibawah ini :',
            style: CustomTextStyle.body2Regular.copyWith(
              color: CustomColor.grey,
            ),
          ),
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  // isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            dense: true,
                            title: Text(
                              'Ambil foto dengan kamera',
                              style: CustomTextStyle.body1Regular,
                            ),
                            leading: const Icon(
                              IconlyBold.camera,
                              color: CustomColor.primary,
                              size: 24,
                            ),
                            onTap: () async {
                              final a =
                                  await blocImage.upload(ImageSource.camera);
                              submissionBloc.poolImage.add(a.url);
                              Navigator.pop(context);
                              snackbarPopup(context);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Ambil foto dari album',
                              style: CustomTextStyle.body1Regular,
                            ),
                            leading: const Icon(
                              IconlyBold.image,
                              color: CustomColor.primary,
                              size: 24,
                            ),
                            onTap: () async {
                              final a =
                                  await blocImage.upload(ImageSource.gallery);
                              submissionBloc.poolImage.add(a.url);
                              Navigator.pop(context);
                              snackbarPopup(context);
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: StreamBuilder<String>(
                  stream: submissionBloc.poolImage.stream,
                  initialData: submissionBloc.poolImage.value,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null) {
                      return Container(
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
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(data),
                              fit: BoxFit.cover),
                          border: Border.all(color: CustomColor.fadedGrey),
                          color: CustomColor.fadedGrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8)),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
