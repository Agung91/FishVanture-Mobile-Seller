import 'package:seller/config/colors.dart';
import 'package:flutter/material.dart';

class OrderStatus {
  // active
// cancel
// success

  static const active = "active";
  static const cancel = "cancel";
  static const success = "success";

  static Color statusColor(String status) {
    return _mapStatus[status] ?? CustomColors.dark;
  }

  static const _mapStatus = {
    active: CustomColors.primary,
    cancel: CustomColors.error,
    success: CustomColors.green,
  };
  static Color statusFadedColor(String status) {
    return _mapFadedStatus[status] ?? CustomColors.dark;
  }

  static const _mapFadedStatus = {
    active: CustomColors.fadedBlue,
    cancel: CustomColors.fadedRed,
    success: CustomColors.fadedGreen,
  };

  static String statusInfo(String status) {
    return _mapStatusInfo[status] ?? '';
  }

  static const _mapStatusInfo = {
    active: 'Sedang Proses',
    cancel: 'Dibatalkan',
    success: 'Selesai',
  };
}
