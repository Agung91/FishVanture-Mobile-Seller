import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:seller/config/colors.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({
    Key? key,
    required this.onRefresh,
    this.label,
  }) : super(key: key);

  final Future<void> Function() onRefresh;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          backgroundColor: CustomColors.background,
          color: CustomColors.primary,
          onRefresh: onRefresh,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(child: Text(label ?? ''))),
            ),
          ),
        );
      },
    );
    ;
  }
}
