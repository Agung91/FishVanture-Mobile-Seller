// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:seller/common/errors/errors.dart';
import 'package:seller/config/colors.dart';

// onSucced: () async {},
// onFailed: (e) async{},
class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    this.isPrimary = true,
    this.smallButton = false,
    this.grafity = false,
    this.textButton = 'Button',
    required this.onTap,
    this.suffixIcon,
    this.isDisabled = false,
    this.onSucced,
    this.onFailed,
  }) : super(key: key);

  final bool isPrimary;
  final bool smallButton;
  final bool grafity;
  final String textButton;
  final dynamic Function() onTap;
  final IconData? suffixIcon;
  final bool isDisabled;

  final Function()? onSucced;
  final Function(Errors)? onFailed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  final _bordeRadius = BorderRadius.circular(8.0);
  bool onLoading = false;
  @override
  Widget build(BuildContext context) {
    if (widget.isDisabled) {
      return _DisabledButton(
        isPrimary: widget.isPrimary,
        smallButton: widget.smallButton,
        grafity: widget.grafity,
        textButton: widget.textButton,
        suffixIcon: widget.suffixIcon,
      );
    }

    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: _bordeRadius,
      ),
      // fillColor: widget.isPrimary ? CustomColor.primary : CustomColor.secondary,
      splashColor: Colors.transparent,
      highlightColor:
          widget.isPrimary ? CustomColor.border : const Color(0x005F4141),
      elevation: 0,
      highlightElevation: widget.grafity ? 2.0 : 0,
      onPressed: onLoading
          ? null
          : () async {
              setState(() {
                onLoading = true;
              });
              widget.onTap().then((v) {
                if (widget.onSucced != null) {
                  widget.onSucced!();
                }
                setState(() {
                  onLoading = false;
                });
              }).catchError((e) {
                if (e is Errors) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message),
                    ),
                  );
                  if (widget.onFailed != null) {
                    widget.onFailed!(e);
                  }
                }

                if (e is List<Errors> && e.isNotEmpty) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e[0].message),
                    ),
                  );
                  if (widget.onFailed != null) {
                    widget.onFailed!(e[0]);
                  }
                }
                setState(() {
                  onLoading = false;
                });
              });
            },
      child: Container(
        height: widget.smallButton ? 32.0 : 43.0,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: _bordeRadius,
            gradient: const LinearGradient(
              colors: [
                CustomColor.primary,
                CustomColor.secondary,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (onLoading)
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    widget.textButton,
                    style: TextStyle(
                      color: widget.isPrimary
                          ? CustomColor.white
                          : CustomColor.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: widget.smallButton ? 10 : 12.0,
                      letterSpacing: 1.25 / 100 * 12,
                    ),
                  ),
            if (widget.suffixIcon != null || onLoading)
              const SizedBox(
                width: 8,
              ),
            if (widget.suffixIcon != null && !onLoading)
              Icon(
                widget.suffixIcon,
                size: 18,
                color: CustomColor.primary,
              ),
          ],
        ),
      ),
    );
  }
}

class _DisabledButton extends StatelessWidget {
  const _DisabledButton({
    Key? key,
    required this.isPrimary,
    required this.smallButton,
    required this.grafity,
    required this.textButton,
    this.suffixIcon,
  }) : super(key: key);
  final bool isPrimary;
  final bool smallButton;
  final bool grafity;
  final String textButton;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: smallButton ? 32.0 : 43.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: CustomColor.defaultBorder,
      ),
      child: (suffixIcon != null)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textButton,
                  style: TextStyle(
                    color: isPrimary ? CustomColor.white : CustomColor.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: smallButton ? 10 : 12.0,
                    letterSpacing: 1.25 / 100 * 12,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Icon(
                  suffixIcon,
                  size: 18,
                  color: CustomColor.primary,
                ),
              ],
            )
          : Center(
              child: Text(
                textButton,
                style: TextStyle(
                  color: CustomColor.dark,
                  fontWeight: FontWeight.w600,
                  fontSize: smallButton ? 10 : 12.0,
                  letterSpacing: 1.25 / 100 * 12,
                ),
              ),
            ),
    );
  }
}
