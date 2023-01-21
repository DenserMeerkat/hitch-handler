import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../customfields/customelevatedbutton.dart';

class DialogCont extends StatelessWidget {
  final Color? headerColor;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? backgroundColor;
  final Color? primaryButtonColor;
  final Color? secondaryButtonColor;
  final Color? buttonTrayColor;
  final Color? closeBackgroundColor;
  final Color? closeIconColor;
  final IconData icon;
  final String title;
  final String message;
  final String primaryButtonLabel;
  final String? secondaryButtonLabel;
  final Function()? primaryFunction;
  final Function()? secondaryFunction;
  final bool showSecondaryButton;
  final double borderRadius;
  final double minHeight;
  const DialogCont({
    super.key,
    this.headerColor = kBlack20,
    this.iconColor = kBlack20,
    this.iconBackgroundColor = kPrimaryColor,
    this.backgroundColor = kGrey50,
    this.primaryButtonColor = kPrimaryColor,
    this.secondaryButtonColor = kGrey150,
    this.buttonTrayColor = kGrey50,
    this.secondaryFunction,
    this.closeIconColor = kGrey150,
    this.closeBackgroundColor = kGrey30,
    required this.icon,
    required this.title,
    required this.message,
    required this.primaryButtonLabel,
    this.secondaryButtonLabel = "Cancel",
    this.primaryFunction,
    this.showSecondaryButton = true,
    this.borderRadius = 5,
    this.minHeight = 50,
  });

  Widget showSecondary(bool showSecondaryButton) {
    if (showSecondaryButton) {
      return Expanded(
        child: ElevatedButtonWithoutIcon(
          onPressed: secondaryFunction,
          label: secondaryButtonLabel!,
          activeColor: secondaryButtonColor!,
        ),
      );
    } else {
      return const SizedBox(
        width: 0,
      );
    }
  }

  Widget showSized(bool showSecondaryButton) {
    if (showSecondaryButton) {
      return const SizedBox(
        width: 30,
      );
    } else {
      return const SizedBox(
        width: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 120,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: headerColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(borderRadius)),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 35,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: iconBackgroundColor,
                        ),
                        child: Center(
                          child: Icon(
                            icon,
                            color: iconColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FittedBox(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kTextColor.withOpacity(0.8),
                            letterSpacing: 1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: closeBackgroundColor,
                ),
                child: Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    splashRadius: 13,
                    splashColor: kGrey50,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: closeIconColor,
                      size: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: minHeight),
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 12,
            bottom: 8,
          ),
          color: backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextColor.withOpacity(0.8),
                  fontSize: 16,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: buttonTrayColor,
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(borderRadius)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 15.0,
              right: 15.0,
              bottom: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 5,
                ),
                showSecondary(showSecondaryButton),
                showSized(showSecondaryButton),
                Expanded(
                  child: ElevatedButtonWithoutIcon(
                    onPressed: primaryFunction,
                    label: primaryButtonLabel,
                    activeColor: primaryButtonColor!,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
