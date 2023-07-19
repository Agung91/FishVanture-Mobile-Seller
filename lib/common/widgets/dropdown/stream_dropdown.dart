import 'package:flutter/material.dart';
import 'package:sstream/sstream.dart';

import 'package:seller/common/widgets/dropdown/dropdown.dart';

class StreamDropdown<T extends DropItem> extends StatelessWidget {
  const StreamDropdown({
    Key? key,
    required this.listItem,
    required this.selected,
    this.hint = 'Pilih',
    this.label,
  }) : super(key: key);

  final SStream<List<T>?> listItem;
  final SStream<T?> selected;
  final String? hint;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 9.0),
        StreamBuilder<List<T>?>(
            stream: listItem.stream,
            initialData: listItem.value,
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null) {
                return Container();
              }
              return StreamBuilder<T?>(
                  stream: selected.stream,
                  initialData: selected.value,
                  builder: (context, snapshot2) {
                    return CustomDropdown(
                      selected: snapshot2.data,
                      listItem: data,
                      hint: hint,
                      onChanged: (item) {
                        if (item is T) selected.add(item);
                      },
                    );
                  });
            }),
      ],
    );
  }
}
