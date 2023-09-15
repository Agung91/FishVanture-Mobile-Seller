import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import 'package:seller/common/custom/custom_date_picker.dart';
import 'package:seller/common/custom/format_number.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/common/widgets/button.dart';
import 'package:seller/common/widgets/text_input.dart';
import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/modules/product/bloc/bloc_product.dart';
import 'package:seller/modules/product/model/create_product_input.dart';

class CreateProductPage extends StatelessWidget {
  const CreateProductPage({
    Key? key,
    required this.budidayaId,
  }) : super(key: key);

  final String budidayaId;

  @override
  Widget build(BuildContext context) {
    final blocProduct = context.read<ProductBloc>();
    return Scaffold(
      appBar: const CustomAppbar(appbarText: 'Tambah Estimasi Panen'),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: DatePicker(
              label: 'Tanggal Estimasi Panen',
              sStream: blocProduct.date,
            ),
          ),
          const SizedBox(height: 16),
          StreamBuilder<List<PriceModel>>(
              stream: blocProduct.listPrice.stream,
              initialData: blocProduct.listPrice.value,
              builder: (context, snapshot) {
                final listData = snapshot.data;
                if (listData == null || listData.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomButton(
                      textButton: 'Tambah Harga',
                      isPrimary: false,
                      onTap: () async {
                        _showAddPrice(context, blocProduct);
                      },
                    ),
                  );
                }
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == listData.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: CustomButton(
                            textButton: 'Tambah Harga',
                            isPrimary: false,
                            onTap: () async {
                              _showAddPrice(context, blocProduct);
                            },
                          ),
                        );
                      }
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Harga ${index + 1}',
                                    style: CustomTextStyle.body1Medium,
                                  ),
                                  InkWell(
                                    onTap: () => blocProduct
                                        .removePrice(listData[index].limit),
                                    child: const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Icon(
                                        IconlyLight.delete,
                                        color: CustomColors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Harga penjualan ${listData[index].limit} kg'),
                                  Text(listData[index].price.toIdr()),
                                ],
                              ),
                            ],
                          ));
                    },
                    separatorBuilder: (context, index) {
                      if (index == listData.length - 1) {
                        return const SizedBox(height: 24);
                      }
                      return const SizedBox(height: 16);
                    },
                    itemCount: listData.length + 1);
              })
        ],
      ),
      bottomNavigationBar: Container(
        color: CustomColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: CustomButton(
          textButton: 'Submit',
          onTap: () async {
            blocProduct.createProduct(budidayaId);
            RouteBloc().pop();
          },
        ),
      ),
    );
  }

  Future<dynamic> _showAddPrice(BuildContext context, ProductBloc blocProduct) {
    return showModalBottomSheet(
      isScrollControlled: true,
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
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            // left: 8.0,
            // right: 8.0,
          ),

          // padding: const EdgeInsets.symmetric(
          //   horizontal: 8.0,
          //   vertical: 12,
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Tambah Harga',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextInput(
                      sStream: blocProduct.weight,
                      label: 'Berat (kg)',
                      hint: 'Berat',
                      keyboardType: TextInputType.number,
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextInput(
                        sStream: blocProduct.price,
                        keyboardType: TextInputType.number,
                        label: 'Harga',
                        hint: 'Harga',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomButton(
                  textButton: 'Tambah',
                  isPrimary: false,
                  onTap: () async {
                    await blocProduct.addPrice();
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
