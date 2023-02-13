import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../resources/auth_methods.dart';
import '../components/utils/customdialog.dart';
import '../components/utils/dialogcont.dart';
import '../launch/launch_screen.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({
    super.key,
  });
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      elevation: 0,
      title: Text(
        "HITCH HANDLER",
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
      backgroundColor: isDark ? kBackgroundColor : kLBackgroundColor,
      surfaceTintColor: isDark ? kBackgroundColor : kLBackgroundColor,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            splashRadius: 20.0,
            icon: Icon(
              Icons.account_box_outlined,
              color: isDark ? kTextColor : kLTextColor,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: "Account",
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          splashRadius: 20.0,
          //splashColor: Colors.transparent,
          icon: Icon(
            Icons.exit_to_app_rounded,
            color: isDark ? kTextColor : kLTextColor,
          ),
          onPressed: () {
            showConfirmDialog(
              context,
              DialogCont(
                title: "Logout",
                message: "Are you sure you want to logout ?",
                icon: Icons.exit_to_app_rounded,
                iconBackgroundColor: kErrorColor.withOpacity(0.7),
                primaryButtonLabel: "Logout",
                primaryButtonColor: kGrey150,
                secondaryButtonColor: kErrorColor.withOpacity(0.7),
                primaryFunction: () async {
                  final navigator = Navigator.of(context);
                  final scaffold = ScaffoldMessenger.of(context);
                  await AuthMethods().signOut();
                  scaffold.removeCurrentSnackBar();
                  navigator.pushNamedAndRemoveUntil(
                      LaunchScreen.routeName, (Route<dynamic> route) => false);
                },
                secondaryFunction: () {
                  Navigator.pop(context);
                },
                borderRadius: 10,
                //showSecondaryButton: false,
              ),
              borderRadius: 10,
            );
          },
          tooltip: "Logout",
        )
      ],
    );
  }
}
