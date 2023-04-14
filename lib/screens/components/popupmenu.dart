// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';

// Project imports:
import 'package:hitch_handler/screens/components/utils/themedialog.dart';
import '../../constants.dart';

class PopupMenu extends StatefulWidget {
  const PopupMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return PopupMenuButton(
      color: isDark ? kGrey40 : kLBlack10,
      surfaceTintColor: isDark ? kGrey40 : kLBlack10,
      splashRadius: 25.0,
      offset: const Offset(-5, 25),
      position: PopupMenuPosition.under,
      icon: Icon(
        Icons.more_vert,
        color:
            isDark ? kTextColor.withOpacity(0.6) : kLTextColor.withOpacity(0.8),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: (context) {
        final bool isDark =
            AdaptiveTheme.of(context).brightness == Brightness.dark;
        return [
          PopupMenuItem<int>(
            onTap: () {
              Future.delayed(
                const Duration(seconds: 0),
                () => showToggleThemeDialog(context),
              );
            },
            value: 0,
            child: Text(
              "Change Theme",
              style: TextStyle(
                color: isDark ? kTextColor : kLTextColor,
              ),
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Text(
              "Get Support",
              style: TextStyle(
                color: isDark ? kTextColor : kLTextColor,
              ),
            ),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 0) {
          () => {}; //Todo
        } else if (value == 1) {
          () => {}; //Todo
        }
      },
    );
  }
}
