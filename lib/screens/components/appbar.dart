// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/models/user.dart' as model;
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/screens/common/settings_page.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(
        appName.toUpperCase(),
        style: TextStyle(
          color: isDark
              ? kTextColor.withOpacity(0.8)
              : kLTextColor.withOpacity(0.8),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: isDark ? kBackgroundColor : kLBlack20,
      surfaceTintColor: isDark ? kBackgroundColor : kLBlack20,
      // leading: Builder(
      //   builder: (BuildContext context) {
      //     return Transform.scale(
      //       scaleX: -1,
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: IconButton(
      //           splashColor: isDark
      //               ? kTextColor.withOpacity(0.1)
      //               : kLTextColor.withOpacity(0.1),
      //           focusColor: isDark
      //               ? kTextColor.withOpacity(0.1)
      //               : kLTextColor.withOpacity(0.1),
      //           highlightColor: isDark
      //               ? kTextColor.withOpacity(0.1)
      //               : kLTextColor.withOpacity(0.1),
      //           hoverColor: isDark
      //               ? kTextColor.withOpacity(0.1)
      //               : kLTextColor.withOpacity(0.1),
      //           splashRadius: 20.0,
      //           icon: Icon(
      //             Icons.exit_to_app_outlined,
      //             color: isDark
      //                 ? kTextColor.withOpacity(0.9)
      //                 : kLTextColor.withOpacity(0.9),
      //           ),
      //           onPressed: () {},
      //           tooltip: "Logout",
      //         ),
      //       ),
      //     );
      //   },
      // ),
      actions: <Widget>[
        IconButton(
          splashColor: isDark
              ? kTextColor.withOpacity(0.1)
              : kLTextColor.withOpacity(0.1),
          focusColor: isDark
              ? kTextColor.withOpacity(0.1)
              : kLTextColor.withOpacity(0.1),
          highlightColor: isDark
              ? kTextColor.withOpacity(0.1)
              : kLTextColor.withOpacity(0.1),
          hoverColor: isDark
              ? kTextColor.withOpacity(0.1)
              : kLTextColor.withOpacity(0.1),
          splashRadius: 20.0,
          icon:
              // Initicon(
              //   text: user.name,
              //   backgroundColor: isDark
              //       ? kPrimaryColor.withOpacity(0.8)
              //       : kLPrimaryColor.withOpacity(0.8),
              //   size: 28,
              //   border: Border.all(
              //       width: 0.2, color: isDark ? Colors.transparent : kGrey30),
              //   style: TextStyle(
              //       color: isDark ? kLTextColor : kLTextColor,
              //       fontWeight: FontWeight.w500),
              // ),
              Icon(
            Icons.settings_outlined,
            color: isDark
                ? kTextColor.withOpacity(0.9)
                : kLTextColor.withOpacity(0.9),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(SettingsPage.routeName);
            //Scaffold.of(context).openEndDrawer();
          },
          tooltip: "Settings",
        ),
        SizedBox(width: 3.w),
      ],
    );
  }
}
