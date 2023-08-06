import 'package:flutter/material.dart';
import 'package:seller/config/colors.dart';

class StatusSubmission {
  static const submission = "submission";
  static const reviewed = "reviewed";
  static const actived = "actived";
  static const disabled = "disabled";

  static Color statusColor(String status) {
    return _mapStatus[status] ?? CustomColors.dark;
  }

  static const _mapStatus = {
    submission: CustomColors.grey,
    reviewed: CustomColors.yellow,
    actived: CustomColors.green,
    disabled: CustomColors.red,
  };

  static String statusInfo(String status) {
    return _mapStatusInfo[status] ?? '';
  }

  static const _mapStatusInfo = {
    submission:
        'Pengajuan Anda telah berhasil diajukan dan akan segera ditinjau dalam waktu maksimal 2 hari.',
    reviewed: 'Saat ini, formulir pengajuan sedang dalam proses peninjauan.',
    actived: '',
    disabled: 'Maaf, formulir pengajuan Anda ditolak ',
  };
}
