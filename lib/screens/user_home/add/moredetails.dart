import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import '../notifiers.dart';
import '../../components/customfields/fieldlabel.dart';
import '../../../constants.dart';

class MoreDetails extends StatefulWidget {
  const MoreDetails({
    super.key,
  });
  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  bool anon = false;
  bool dept = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(
            fgcolor: isDark ? kPrimaryColor : kLPrimaryColor,
            title: "More Details",
            bgcolor: isDark ? kBlack15 : kGrey30,
            tooltip: 'tooltip'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
              color: isDark ? kGrey50 : kLBlack10,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 3),
                  color: isDark ? kBlack20 : kGrey150,
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text(
                  'Do you want this to be an Anonymous entry?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? kTextColor.withOpacity(0.8)
                        : kLTextColor.withOpacity(0.8),
                  ),
                ),
                activeColor: isDark ? kPrimaryColor : kLPrimaryColor,
                activeTrackColor: isDark ? kBlack20 : kGrey30,
                inactiveThumbColor: isDark ? kGrey90 : kLGrey40,
                inactiveTrackColor: isDark ? kBlack20 : kGrey40,
                value: anon,
                onChanged: (bool value) {
                  setState(() {
                    anon = !anon;
                    SwitchChanged(anon, dept).dispatch(context);
                  });
                },
              ),
              Divider(
                thickness: 1.0,
                color: isDark ? kBlack20 : kGrey90,
              ),
              SwitchListTile(
                title: Text(
                  'Is this a problem in your department?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? kTextColor.withOpacity(0.8)
                        : kLTextColor.withOpacity(0.8),
                  ),
                ),
                activeColor: isDark ? kPrimaryColor : kLPrimaryColor,
                activeTrackColor: isDark ? kBlack20 : kGrey30,
                inactiveThumbColor: isDark ? kGrey90 : kLGrey40,
                inactiveTrackColor: isDark ? kBlack20 : kGrey40,
                value: dept,
                onChanged: (bool value) {
                  setState(() {
                    dept = !dept;
                    SwitchChanged(anon, dept).dispatch(context);
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
