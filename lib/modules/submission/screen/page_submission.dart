import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'package:seller/common/file_picker/bloc_upload_file.dart';
import 'package:seller/common/file_picker/repo_upload_file.dart';
import 'package:seller/common/image_picker/bloc_upload_image.dart';
import 'package:seller/common/image_picker/repo_upload_image.dart';
import 'package:seller/common/snackbar/snackbar_popup.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/common/widgets/dropdown/stream_dropdown.dart';
import 'package:seller/common/widgets/text_input.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/address/repo/repo_address.dart';
import 'package:seller/modules/pond/bloc/bloc_pond.dart';
import 'package:seller/modules/pool/model/model_pool.dart';
import 'package:seller/modules/submission/bloc/bloc_submission.dart';
import 'package:seller/modules/submission/repo/repo_submission.dart';
import 'package:seller/modules/submission/widget/w_submission_pool.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final addressBloc = AddressBloc(AddressHttpRepo());
    final pondBloc = PondBloc();

    return Provider(
      create: (context) => SubmissionBloc(
        SubmissionHttpRepo(),
        AddressHttpRepo(),
      ),
      builder: (context, child) {
        final blocSubmission = context.read<SubmissionBloc>();
        return Scaffold(
          backgroundColor: CustomColors.background,
          appBar: const CustomAppbar(appbarText: 'Pengajuan Budidaya'),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  color: CustomColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      TextInput(
                        sStream: blocSubmission.name,
                        label: 'Pemilik Budidaya',
                        hint: 'Masukkan Nama',
                      ),
                      const SizedBox(height: 26),
                      StreamDropdown(
                        label: 'Negara',
                        hint: 'Pilih Negara',
                        listItem: blocSubmission.countrys,
                        selected: blocSubmission.country,
                      ),
                      const SizedBox(height: 26),
                      StreamDropdown(
                        label: 'Provinsi',
                        hint: 'Pilih Provinsi',
                        listItem: blocSubmission.provinces,
                        selected: blocSubmission.province,
                      ),
                      const SizedBox(height: 26),
                      StreamDropdown(
                        label: 'Kabupaten/Kota',
                        hint: 'Pilih Kabupaten/Kota',
                        listItem: blocSubmission.citys,
                        selected: blocSubmission.city,
                      ),
                      const SizedBox(height: 26),
                      StreamDropdown(
                        label: 'Kecamatan',
                        hint: 'Pilih Kecamatan',
                        listItem: blocSubmission.districts,
                        selected: blocSubmission.district,
                      ),
                      const SizedBox(height: 26),
                      TextInput(
                        sStream: blocSubmission.detailAddres,
                        label: 'Detail Alamat',
                        hint: 'Masukkan Detail Alamat',
                      ),
                      const SizedBox(height: 26),
                      TextInput(
                        sStream: blocSubmission.noteAddres,
                        label: 'Catatan Alamat',
                        hint: 'Masukkan Catatan Alamat',
                      ),
                      const SizedBox(height: 26),
                      Text(
                          'Catatan : Tekan "Ambil Lokasi" untuk mengambil lokasi saat ini. Pastikan Anda berada di area yang akan didaftarkan.'),
                      const SizedBox(height: 12),
                      StreamBuilder<LocationData?>(
                          stream: blocSubmission.initialKoordinat.stream,
                          initialData: blocSubmission.initialKoordinat.value,
                          builder: (context, snapshot) {
                            final dataKoordinat = snapshot.data;
                            if (dataKoordinat == null) {
                              return TextButton(
                                onPressed: () async {
                                  Location location = Location();

                                  // late bool _serviceEnabled;
                                  // late PermissionStatus _permissionGranted;
                                  // late LocationData _locationData;

                                  var _serviceEnabled =
                                      await location.serviceEnabled();
                                  if (!_serviceEnabled) {
                                    _serviceEnabled =
                                        await location.requestService();
                                    if (!_serviceEnabled) {
                                      return;
                                    }
                                  }

                                  var _permissionGranted =
                                      await location.hasPermission();
                                  if (_permissionGranted ==
                                      PermissionStatus.denied) {
                                    _permissionGranted =
                                        await location.requestPermission();
                                    if (_permissionGranted !=
                                        PermissionStatus.granted) {
                                      return;
                                    }
                                  }

                                  var _locationData =
                                      await location.getLocation();
                                  blocSubmission.initialKoordinat
                                      .add(_locationData);

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
                                  // print(_locationData);
                                  // print(_locationData.accuracy);
                                  // print(_locationData.altitude);
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
                                  color: CustomColors.fadedGrey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                'Koordinat: ${dataKoordinat.latitude}, ${dataKoordinat.longitude}',
                              ),
                            );
                          }),
                      const SizedBox(height: 26),
                      _SelectType(),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daftar Kolam',
                          style: CustomTextStyle.body2SemiBold,
                        ),
                        TextButton(
                            onPressed: () {
                              RouteBloc().push(RoutePool(blocSubmission));
                            },
                            child: Text(
                              'Tambah Kolam',
                              style: CustomTextStyle.body2Medium.copyWith(
                                color: CustomColors.primary,
                              ),
                            ))
                      ],
                    )),
                const SizedBox(height: 4),
                SizedBox(
                  height: 180,
                  child: StreamBuilder<List<PoolModel>>(
                      stream: blocSubmission.listPool.stream,
                      initialData: blocSubmission.listPool.value,
                      builder: (context, snapshot) {
                        final listPool = snapshot.data;
                        if (listPool == null || listPool.isEmpty) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: CustomColors.white,
                            ),
                            child: const Center(
                              child: Text(
                                  'Saat ini belum ada data terkait kolam.'),
                            ),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return WSubmissionPool(
                              pool: listPool[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 8);
                          },
                          itemCount: listPool.length,
                        );
                      }),
                ),
                const SizedBox(height: 26),
                _WUploadFile(submissionBloc: blocSubmission),
                const SizedBox(height: 26),
                _WPhoto(blocSubmission: blocSubmission),
                const SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomButton(
                    textButton: 'Submit',
                    onTap: () async {
                      await blocSubmission.createPond().catchError((e) {
                        snacBarPopUp(
                          text: e,
                          color: CustomColors.red,
                          icon: Iconsax.close_square5,
                        );
                      });
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
      },
    );
  }
}

class _SelectType extends StatelessWidget {
  const _SelectType({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> listData = ['Mandiri', 'Kelompok'];
    final bloc = context.read<SubmissionBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jenis Pengajuan',
          style: CustomTextStyle.body2Medium,
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 50,
          child: ListView.separated(
            itemBuilder: (ctx, i) {
              return StreamBuilder<int?>(
                  stream: bloc.type.stream,
                  initialData: bloc.type.value,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? 0;
                    return RadioMenuButton(
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      value: i,
                      groupValue: data,
                      onChanged: (value) {
                        bloc.type.add(value ?? 0);
                      },
                      child: Text(
                        listData[i],
                        style: CustomTextStyle.body2Medium,
                      ),
                    );
                  });
            },
            separatorBuilder: (ctx, i) {
              return const SizedBox(
                width: 24,
              );
            },
            itemCount: listData.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }
}

class _WUploadFile extends StatelessWidget {
  const _WUploadFile({
    Key? key,
    required this.submissionBloc,
  }) : super(key: key);

  final SubmissionBloc submissionBloc;

  @override
  Widget build(BuildContext context) {
    final uploadFileBloc = UploadFileBloc(UploadFileHttpRepo());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: BoxDecoration(
        color: CustomColors.white,
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
          StreamBuilder<double>(
              stream: uploadFileBloc.uploadProgress.stream,
              builder: (context, snapshot) {
                final dataProgress = snapshot.data;
                if (dataProgress == 0.0 || dataProgress == null) {
                  return InkWell(
                    onTap: () async {
                      final response =
                          await uploadFileBloc.pickFile().catchError((e) {
                        snacBarPopUp(
                            text: 'File terlalu besar',
                            color: CustomColors.red,
                            icon: IconlyBold.paper_fail);
                      });
                      submissionBloc.file.add(response);
                      submissionBloc.addFile();
                    },
                    child: StreamBuilder<String>(
                        stream: uploadFileBloc.name.stream,
                        initialData: uploadFileBloc.name.value,
                        builder: (context, snapshot) {
                          final dataName = snapshot.data;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: (dataName == 'Success')
                                  ? CustomColors.green
                                  : CustomColors.primary,
                            ),
                            child: Text(
                              dataName ?? 'Upload',
                              style: CustomTextStyle.body1Medium
                                  .copyWith(color: CustomColors.white),
                            ),
                          );
                        }),
                  );
                }
                return SizedBox(
                  height: 80,
                  width: 80,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            backgroundColor: CustomColors.fadedGrey,
                            color: CustomColors.primary,
                            value: dataProgress,
                            strokeWidth: 6,
                          ),
                        ),
                      ),
                      Center(child: Text('${(dataProgress * 100).toInt()}%'))
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}

class _WPhoto extends StatelessWidget {
  const _WPhoto({
    Key? key,
    required this.blocSubmission,
  }) : super(key: key);

  final SubmissionBloc blocSubmission;

  @override
  Widget build(BuildContext context) {
    final blocImage = ImageUploaderBloc(UploadImageHttpRepo());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: CustomColors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foto Tempat Budidaya',
            style: CustomTextStyle.body2SemiBold.copyWith(
              color: CustomColors.primary,
            ),
          ),
          const Divider(),
          Text(
            'Silahkan upload Foto Tempat Budidaya sebagai icon Anda dengan cara menyentuh area/foto dibawah ini :',
            style: CustomTextStyle.body2Regular.copyWith(
              color: CustomColors.grey,
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
                              color: CustomColors.primary,
                              size: 24,
                            ),
                            onTap: () async {
                              final a =
                                  await blocImage.upload(ImageSource.camera);
                              blocSubmission.imagePond.add(a.url);
                              Navigator.pop(context);
                              snacBarPopUp(
                                  text: 'Berhasil upload gambar',
                                  color: CustomColors.green,
                                  icon: IconlyBold.tick_square);
                            },
                          ),
                          ListTile(
                            title: Text(
                              'Ambil foto dari album',
                              style: CustomTextStyle.body1Regular,
                            ),
                            leading: const Icon(
                              IconlyBold.image,
                              color: CustomColors.primary,
                              size: 24,
                            ),
                            onTap: () async {
                              final a =
                                  await blocImage.upload(ImageSource.gallery);
                              blocSubmission.imagePond.add(a.url);
                              if (kDebugMode) {
                                print(a.url);
                              }
                              Navigator.pop(context);
                              snacBarPopUp(
                                  text: 'Berhasil upload gambar',
                                  color: CustomColors.green,
                                  icon: IconlyBold.tick_square);
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: StreamBuilder<String>(
                  stream: blocSubmission.poolImage.stream,
                  initialData: blocSubmission.poolImage.value,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null || data == '') {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: CustomColors.fadedGrey),
                            color: CustomColors.fadedGrey.withOpacity(0.3),
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
                          border: Border.all(color: CustomColors.fadedGrey),
                          color: CustomColors.fadedGrey.withOpacity(0.3),
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
