import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:seller/common/widgets/appbar.dart';
import 'package:seller/modules/pond/bloc/bloc_pond.dart';
import 'package:seller/modules/pond/model/model_pond.dart';

class PondPage extends StatelessWidget {
  const PondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pondBloc = context.read<PondBloc>();
    return Scaffold(
      appBar: CustomAppbar(appbarText: 'Pengaturan Produk'),
      body: Center(
        child: Text('Data'),
      ),
    );
  }
}
