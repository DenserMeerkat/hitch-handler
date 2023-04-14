// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.bgcolor,
    required this.tooltip,
  });

  final Color fgcolor;
  final String title;
  final Color bgcolor;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Tooltip(
      preferBelow: false,
      triggerMode: TooltipTriggerMode.tap,
      message: tooltip,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: bgcolor,
        border: Border.all(color: kTextColor.withAlpha(100), width: 1),
      ),
      padding: const EdgeInsets.all(8.0),
      textStyle: const TextStyle(
        color: kTextColor,
        fontSize: 15,
      ),
      showDuration: const Duration(seconds: 2),
      waitDuration: const Duration(seconds: 1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 4.0),
            Text(
              title,
              style: TextStyle(
                color: isDark ? kTextColor.withOpacity(0.7) : kLTextColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 10.0),
            Icon(
              Icons.help_outline_outlined,
              color: isDark ? fgcolor.withOpacity(0.7) : kLTextColor,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
