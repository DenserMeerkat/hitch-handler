// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';

class DialogTextFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool clear;
  final void Function()? onPressed;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final IconData icon;
  final bool enabled;
  final int? minLines;
  final int? maxLines;
  const DialogTextFormField({
    super.key,
    this.validator,
    required this.controller,
    required this.clear,
    this.onPressed,
    required this.hintText,
    required this.keyboardType,
    required this.icon,
    this.enabled = true,
    this.minLines,
    this.maxLines,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color) {
      OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10.r),
      );
      return outlineInputBorder;
    }

    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      enabled: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
        border: border(Colors.transparent),
        focusedBorder: border(kPrimaryColor),
        errorBorder: border(AdaptiveTheme.of(context).theme.colorScheme.error),
        enabledBorder: border(isDark ? kGrey70 : kLBlack20),
        disabledBorder: border(Colors.transparent),
        suffixIconColor: enabled
            ? kPrimaryColor
            : isDark
                ? kTextColor.withOpacity(0.3)
                : kLTextColor.withOpacity(0.2),
        suffixIcon: clear
            ? IconButton(
                onPressed: onPressed ??
                    () {
                      controller.clear();
                    },
                icon: const Icon(
                  Icons.clear,
                ),
              )
            : Icon(
                icon,
              ),
        hintText: hintText,
        hintStyle:
            AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.copyWith(
                  color: isDark
                      ? kTextColor.withOpacity(0.5)
                      : kLTextColor.withOpacity(0.5),
                ),
        fillColor: isDark ? kGrey50 : kLBlack15,
        filled: true,
      ),
    );
  }
}
