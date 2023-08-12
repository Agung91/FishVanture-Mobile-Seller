import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seller/common/widgets/appbar.dart';

class DetailBudidayaPage extends StatelessWidget {
  const DetailBudidayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appbarText: 'Detail Budidaya'),
    );
  }
}
