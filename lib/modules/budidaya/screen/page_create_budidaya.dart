import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seller/common/widgets/appbar.dart';

class CreateBudidayaPage extends StatelessWidget {
  const CreateBudidayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appbarText: 'Mulai Budidaya'),
    );
  }
}
