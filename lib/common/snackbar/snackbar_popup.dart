import 'package:seller/config/colors.dart';
import 'package:seller/config/text_style.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';

void snackbarPopup(BuildContext context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

final snackBar = SnackBar(
    duration: const Duration(milliseconds: 1200),
    // duration: const Duration(milliseconds: 10000000),
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    content: Container(
      // height: 74.0,

      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),

      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8.0),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Berhasil masuk ke keranjang',
              style: CustomTextStyle.body1Medium.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Iconsax.shopping_cart,
            color: Colors.white,
            size: 20.0,
          )
        ],
      ),
    ));
