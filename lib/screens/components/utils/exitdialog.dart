import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';

void exitDialog(BuildContext context, String homeroute) {
  showAlertDialog(
    context,
    "Exit Process",
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Are you sure you want to go back? You have an ongoing process ",
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
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.popUntil(context, ModalRoute.withName(homeroute));
        },
      )
    ],
    Icons.arrow_back,
  );
}
