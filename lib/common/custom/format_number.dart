//

import 'package:intl/intl.dart';

extension IntExtention on int {
  String toIdr() {
    return NumberFormat.currency(locale: "id", symbol: "Rp ", decimalDigits: 0)
        .format(this);
  }
}

extension DoubleExtention on double {
  String toIdr() {
    return NumberFormat.currency(locale: "id", symbol: "Rp ", decimalDigits: 0)
        .format(this);
  }
}
