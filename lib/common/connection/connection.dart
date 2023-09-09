import 'package:seller/common/custom/debouncer.dart';
import 'package:seller/common/snackbar/snackbar_popup.dart';
import 'package:seller/config/colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:iconsax/iconsax.dart';

class NetworkState {
  factory NetworkState() {
    return _intance;
  }
  final _debouncer = Debouncer(msDelay: 10000);

  NetworkState._() {
    Connectivity().checkConnectivity().then(_onChange);
    Connectivity().onConnectivityChanged.listen(_onChange);
  }

  static final _intance = NetworkState._();

  void _onChange(ConnectivityResult event) {
    if (event == ConnectivityResult.none) {
      if (!_connected) {
        return;
      }
      _connected = false;
      _debouncer.run(() {
        snacBarPopUp(
          message: 'Koneksi terputus',
          duration: 1600,
          color: CustomColors.error,
          icon: Iconsax.danger5,
        );
      });
      return;
    }
    _debouncer.run(() {});
    _connected = true;
  }

  bool _connected = true;
  bool get isConnected => _connected;
}
