import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:seller/config/colors.dart';

class CustomDropdown<T extends DropItem> extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    required this.listItem,
    this.selected,
    this.onChanged,
    this.hint,
  }) : super(key: key);

  final List<T> listItem;
  final T? selected;
  final Function(DropItem? item)? onChanged;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColor.fadedGrey,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          hint: Text(
            hint ?? '',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          value: selected,
          items: listItem
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(e.label(),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              )
              .toList(),
          onChanged: onChanged,
          isExpanded: true,
          icon: const Icon(
            IconlyLight.arrow_down_2,
            size: 16.0,
            color: CustomColor.dark,
          ),
          // isDense: true,
        ),
      ),
    );
  }
}

abstract class DropItem {
  String label();
  dynamic value();
}

class GenericDropItem<T> extends DropItem {
  GenericDropItem(this._label, this._value);
  final String _label;
  final T _value;
  @override
  value() => _value;
  @override
  label() => _label;
}

class ValueDropItem<T> extends DropItem {
  ValueDropItem(this._value);
  final T _value;
  @override
  value() => _value;
  @override
  label() => _value.toString();
}
