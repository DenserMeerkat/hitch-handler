import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';

class CustomIconButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final Color? iconColor;
  final Color? bgColor;
  final Function()? onTap;
  final BoxBorder? border;
  final double size;
  const CustomIconButton({
    super.key,
    required this.icon,
    this.iconColor,
    this.onTap,
    required this.tooltip,
    this.bgColor,
    this.border,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Tooltip(
      message: tooltip,
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: bgColor ?? (isDark ? kGrey30 : kErrorColor.withOpacity(0.3)),
            border: border ??
                Border.all(
                  color: isDark ? kGrey40 : kLGrey30,
                ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                color: iconColor ?? (isDark ? kErrorColor : kLTextColor),
                size: size,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
