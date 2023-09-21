import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:seller/modules/budidaya/bloc/bloc_budidaya.dart';
import 'package:seller/modules/budidaya/model/model_budidaya.dart';
import 'package:seller/modules/budidaya/model/model_price_list.dart';
import 'package:seller/modules/product/bloc/bloc_product.dart';
import 'package:seller/modules/product/model/create_product_input.dart';

class UpdateProductPage extends StatelessWidget {
  const UpdateProductPage({
    Key? key,
    required this.budidayaModel,
  }) : super(key: key);

  final BudidayaModel budidayaModel;

  @override
  Widget build(BuildContext context) {
    final blocProduct = context.read<ProductBloc>();
    final blocBudidaya = context.read<BudidayaBloc>();
    blocProduct.listPrice.add(budidayaModel.priceList);
    if (budidayaModel.estTonase != null) {
      blocProduct.estTonase.add(budidayaModel.estTonase!.toInt().toString());
    }
    blocProduct.date.add(budidayaModel.estPanenDate);
    return Scaffold(
      appBar: const CustomAppbar(appbarText: 'Perbarui Estimasi Panen'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DatePicker(
                label: 'Tanggal Estimasi Panen',
                helpText: 'PILIH TANGGAL ESTIMASI PANEN',
                sStream: blocProduct.date,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: StreamTextInput(
                  label: 'Perkiraan Jumlah Panen(kg)',
                  hint: 'Jumlah Panen',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]*')),
                  ],
                  keyboardType: TextInputType.number,
                  sStream: blocProduct.estTonase,
                )),
            const SizedBox(height: 16),
            StreamBuilder<List<PriceListModel>?>(
                stream: blocProduct.listPrice.stream,
                initialData: blocProduct.listPrice.value,
                builder: (context, snapshot) {
                  final listData = snapshot.data;
                  if (listData == null || listData.isEmpty) {
                    return const SizedBox();
                  }
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${listData[index].limit} kg',
                                        style: CustomTextStyle.body1Medium,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          blocProduct
                                              .currentPrice(listData[index]);

                                          // TODO MENGGUNAKAN TANDA SERU
                                          _showAddPriceDefault(
                                            context,
                                            blocProduct,
                                            budidayaModel.priceList![index],
                                          );
                                        },
                                        child: const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Icon(
                                            IconlyLight.edit,
                                            color: CustomColors.yellow,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            'Harga penjualan dalam ${listData[index].limit}kg keatas'),
                                      ),
                                      Expanded(
                                          child: Align(
                                        alignment: Alignment.centerRight,
                                        child:
                                            Text(listData[index].price.toIdr()),
                                      )),
                                    ],
                                  ),
                                ],
                              ));
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
                                      '${listData[index].limit}kg',
                                      style: CustomTextStyle.body1Medium,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        blocProduct
                                            .currentPrice(listData[index]);

                                        // TODO MENGGUNAKAN TANDA SERU
                                        _showUpdatePrice(
                                          context,
                                          blocProduct,
                                          budidayaModel.priceList![index],
                                        );
                                      },
                                      child: const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Icon(
                                          IconlyLight.edit,
                                          color: CustomColors.yellow,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          'Harga penjualan dalam ${listData[index].limit}kg keatas'),
                                    ),
                                    Expanded(
                                        child: Align(
                                      alignment: Alignment.centerRight,
                                      child:
                                          Text(listData[index].price.toIdr()),
                                    )),
                                  ],
                                ),
                              ],
                            ));
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                      itemCount: listData.length);
                }),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: CustomColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: CustomButton(
          textButton: 'Submit',
          onTap: () async {
            await blocProduct.updateProduct(budidayaModel.id);
            blocBudidaya.getListBudidaya();
            RouteBloc().pop();
            RouteBloc().pop();
          },
        ),
      ),
    );
  }

  Future<dynamic> _showUpdatePrice(BuildContext context,
      ProductBloc blocProduct, PriceListModel priceListModel) {
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
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Perbarui Harga',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Harga yang diinputkan adalah harga yang berlaku untuk setiap kilogram barang yang akan dibeli',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: StreamTextInput(
                      sStream: blocProduct.weight,
                      label: 'Berat (kg)',
                      hint: 'Berat',
                      keyboardType: TextInputType.number,
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                      child: StreamTextInput(
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
                  textButton: 'Submit',
                  isPrimary: false,
                  onTap: () async {
                    blocProduct.updatePrice(priceListModel);
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

  Future<dynamic> _showAddPriceDefault(
    BuildContext context,
    ProductBloc blocProduct,
    PriceListModel priceListModel,
  ) {
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
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Perbarui Harga Normal',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Harga yang diinputkan adalah harga yang berlaku untuk setiap kilogram barang yang akan dibeli',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: StreamTextInput(
                        sStream: blocProduct.price,
                        keyboardType: TextInputType.number,
                        label: 'Harga Awal',
                        hint: 'Masukkan Harga Awal',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomButton(
                  textButton: 'Submit',
                  isPrimary: false,
                  onTap: () async {
                    blocProduct.updatePriceDefault(priceListModel);
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
