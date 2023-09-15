import 'package:flutter/material.dart';
import 'package:intl/intl_standalone.dart';
import 'package:seller/config/colors.dart';
import 'package:sstream/sstream.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.sStream,
    this.label,
  }) : super(key: key);

  final SStream<DateTime?> sStream;
  final String? label;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    final dateNow = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? 'Tanggal Mulai Budidaya',
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 9.0),
        InkWell(
          onTap: () async {
            Intl.systemLocale = await findSystemLocale();
            final data = await showDatePicker(
              context: context,
              initialDate: dateNow,
              firstDate: DateTime(dateNow.year - 1),
              lastDate: DateTime(dateNow.year + 2),
              helpText: 'PILIH TANGGAL MULAI BUDIDAYA',
              cancelText: 'BATAL',
              confirmText: 'SIMPAN',
            );
            if (data != null) {
              widget.sStream.add(data);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: CustomColors.fadedGrey),
                borderRadius: BorderRadius.circular(4)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: StreamBuilder<DateTime?>(
                  stream: widget.sStream.stream,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null) {
                      return const Text(
                        'Pilih tanggal',
                        style: TextStyle(
                          color: CustomColors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }
                    return Text(
                      DateFormat('EEEE, dd MMMM yyyy', 'id').format(data),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
