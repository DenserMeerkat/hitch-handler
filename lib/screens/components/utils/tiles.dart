// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/models/user.dart' as model;
import 'package:hitch_handler/providers/user_provider.dart';

class StatusTile extends StatelessWidget {
  const StatusTile({
    super.key,
    required this.index,
    required this.isDark,
    required this.iconColor,
    required this.leading,
    required this.statusTitle,
    required this.snap,
  });

  final int index;
  final bool isDark;
  final Color iconColor;
  final IconData leading;
  final String statusTitle;
  final dynamic snap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: index == 0 ? 8 : 4),
      decoration: BoxDecoration(
          color: isDark ? kGrey30 : kLBlack15.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: index == 0 && snap['name'] != "<First Log>" ? 2 : 1,
              color: index == 0 && snap['name'] != "<First Log>"
                  ? kPrimaryColor
                  : isDark
                      ? kGrey50
                      : kLBlack20)),
      child: Theme(
        data: AdaptiveTheme.of(context)
            .theme
            .copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          dense: true,
          child: ExpansionTile(
            tilePadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            leading: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                leading,
                size: 20,
                color: isDark ? kTextColor : kLTextColor,
              ),
            ),
            iconColor: kPrimaryColor,
            collapsedIconColor: kPrimaryColor,
            title: AutoSizeText(
              statusTitle,
              style: TextStyle(
                  color: isDark ? kTextColor : kLTextColor,
                  fontSize: 14,
                  letterSpacing: 1),
            ),
            subtitle: AutoSizeText(
              snap['name'],
              maxLines: 1,
              style: TextStyle(
                  color: isDark
                      ? kTextColor.withOpacity(0.7)
                      : kLTextColor.withOpacity(0.7)),
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              AccountListTile(
                  text: snap['message'], icon: Icons.comment_outlined),
              AccountListTile(
                text: DateFormat.yMMMMd().format(
                    DateTime.fromMicrosecondsSinceEpoch(
                        snap['datePublished'].microsecondsSinceEpoch)),
                icon: Icons.calendar_month_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountTile extends StatefulWidget {
  const AccountTile({super.key});

  @override
  State<AccountTile> createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? kGrey30 : kLGrey30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: AdaptiveTheme.of(context).theme.copyWith(
              brightness: AdaptiveTheme.of(context).brightness,
              useMaterial3: true,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          tilePadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          textColor: isDark ? kTextColor : kLTextColor,
          collapsedTextColor: isDark ? kTextColor : kLTextColor,
          iconColor: isDark ? kPrimaryColor : kLPrimaryColor,
          collapsedIconColor: isDark ? kTextColor : kLTextColor,
          backgroundColor: isDark ? kGrey30 : kLBlack10,
          collapsedBackgroundColor: isDark ? kGrey30 : kLBlack10,
          leading: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Initicon(
              text: user.name,
              backgroundColor: isDark
                  ? kPrimaryColor.withOpacity(0.8)
                  : kLPrimaryColor.withOpacity(0.8),
              size: 40,
              elevation: 2,
              border: Border.all(
                  width: 0.5, color: isDark ? Colors.transparent : kGrey30),
              style: TextStyle(
                  color: isDark ? kLTextColor : kLTextColor,
                  fontWeight: FontWeight.w500),
            ),
          ),
          title: AutoSizeText(
            user.name,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            "Department  •  Year",
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              letterSpacing: 1,
              fontSize: 11.0,
            ),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          children: <Widget>[
            AccountListTile(
              text: user.rollno,
              icon: Icons.badge_outlined,
              lightColor: kLBlack15,
            ),
            AccountListTile(
              text: user.email,
              icon: Icons.alternate_email,
              lightColor: kLBlack15,
            ),
            AccountListTile(
              text: user.mobno,
              icon: Icons.numbers,
              lightColor: kLBlack15,
            ),
            AccountListTile(
              text: user.dob,
              icon: Icons.calendar_month_outlined,
              lightColor: kLBlack15,
            ),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}

class AccountListTile extends StatelessWidget {
  const AccountListTile({
    super.key,
    required this.text,
    required this.icon,
    this.lightColor = kLBlack10,
  });
  final IconData icon;
  final String text;
  final Color lightColor;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? kGrey40 : lightColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark ? kPrimaryColor : kPrimaryColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AutoSizeText(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? kTextColor : kLTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Function()? press;
  const SettingTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).theme.brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.0),
      child: ListTileTheme(
        tileColor: isDark ? kGrey30 : kLBlack10,
        textColor: isDark ? kTextColor : kLTextColor,
        iconColor:
            isDark ? kTextColor.withOpacity(0.8) : kLTextColor.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isDark ? Colors.transparent : kLGrey30,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: press ?? press,
          leading: Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: isDark
                      ? kPrimaryColor.withOpacity(0.2)
                      : kLPrimaryColor.withOpacity(0.4)),
              color: isDark
                  ? kPrimaryColor.withOpacity(0.3)
                  : kLPrimaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              shadows: [
                BoxShadow(
                  blurRadius: 10,
                  color: isDark ? Colors.transparent : kLGrey30,
                ),
              ],
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
                color: isDark ? kTextColor : kLTextColor, fontSize: 14),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyle(
                      color: isDark
                          ? kTextColor.withOpacity(0.7)
                          : kLTextColor.withOpacity(0.7),
                      fontSize: 12),
                )
              : null,
        ),
      ),
    );
  }
}
