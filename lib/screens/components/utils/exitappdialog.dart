// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

// Project imports:
import 'package:hitch_handler/screens/components/utils/customdialog.dart';

void exitAppDialog(BuildContext context) {
  showAlertDialog(
    context,
    "Exit Apllication",
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Click Exit to close app.",
          style: AdaptiveTheme.of(context).theme.textTheme.bodyLarge,
        ),
      ],
    ),
    [
      buildCancelButton(context),
      buildActiveButton(
        context,
        true,
        "Exit",
        () {
          FlutterExitApp.exitApp(iosForceExit: true);
        },
      )
    ],
    Icons.cancel_outlined,
  );
}
