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
    return AppBar(
      elevation: 0,
      title: Text(
        "HITCH HANDLER",
        style: TextStyle(
          color: kTextColor.withOpacity(0.8),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: kBackgroundColor,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            splashRadius: 20.0,
            icon: const Icon(
              Icons.account_box_outlined,
              color: kTextColor,
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
          icon: const Icon(
            Icons.exit_to_app_rounded,
            color: kTextColor,
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
                  navigator.pushReplacementNamed(LaunchScreen.routeName);
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
