import 'package:seller/common/errors/errors.dart';
import 'package:seller/config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sstream/sstream.dart';

import 'package:seller/config/colors.dart';
import 'package:seller/config/text_field_border.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    Key? key,
    this.label,
    this.hint,
    this.obscureText,
    this.isEnabled = true,
    this.keyboardType,
    this.sStream,
  }) : super(key: key);

  final String? label;
  final String? hint;
  final bool? obscureText;
  final bool isEnabled;
  final TextInputType? keyboardType;
  final SStream<String>? sStream;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _controller = TextEditingController();
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.label ?? '',
              style: CustomTextStyle.body2Regular,
            ),
          ),
        StreamBuilder<String?>(
          stream: widget.sStream?.stream,
          initialData: widget.sStream?.value,
          builder: (context, snapshot) {
            _controller.value = _controller.value.copyWith(text: snapshot.data);
            final err = snapshot.error as Errors?;
            return TextField(
              style: CustomTextStyle.body2Regular.copyWith(
                color: CustomColors.dark,
              ),
              controller: _controller,
              onChanged: widget.sStream?.add,
              obscureText: (widget.obscureText ?? false) && _obsecureText,
              cursorWidth: 1.5,
              cursorColor: CustomColors.primary,
              keyboardType: widget.keyboardType,
              decoration: CustomBorder.border.copyWith(
                hintText: widget.hint,
                hintStyle: const TextStyle(color: CustomColors.grey),
                enabled: widget.isEnabled,
                filled: !widget.isEnabled,
                fillColor: const Color(0xffEEEEEE),
                isDense: true,
                errorText: (err != null) ? err.message : null,
                suffixIcon: (widget.obscureText ?? false)
                    ? IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          setState(
                            () {
                              _obsecureText = !_obsecureText;
                            },
                          );
                        },
                        icon: _obsecureText
                            ? const Icon(
                                Iconsax.eye_slash,
                                size: 16.0,
                              )
                            : const Icon(
                                Iconsax.eye,
                                size: 16.0,
                              ),
                      )
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }
}
