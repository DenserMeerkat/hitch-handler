import 'package:flutter/material.dart';
import '../../components/customfields/fieldlabel.dart';
import '../../../constants.dart';

class MoreDetails extends StatefulWidget {
  bool anon;
  bool dept;
  MoreDetails({
    super.key,
    required this.anon,
    required this.dept,
  });
  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(
            fgcolor: kPrimaryColor,
            title: "More Details",
            bgcolor: kBlack15,
            tooltip: 'tooltip'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: const BoxDecoration(
              color: kGrey50,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
                  color: kBlack20,
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
                    color: kTextColor.withOpacity(0.8),
                  ),
                ),
                enableFeedback: true,
                activeColor: kPrimaryColor,
                activeTrackColor: kBlack20,
                inactiveThumbColor: kGrey90,
                inactiveTrackColor: kBlack20,
                tileColor: kGrey40,
                value: widget.anon,
                onChanged: (bool value) {
                  setState(() {
                    widget.anon = value;
                  });
                },
              ),
              const Divider(
                thickness: 1.0,
                color: kBlack20,
              ),
              SwitchListTile(
                title: Text(
                  'Is this a problem in your department?',
                  style: TextStyle(
                    fontSize: 15,
                    color: kTextColor.withOpacity(0.8),
                  ),
                ),
                enableFeedback: true,
                activeColor: kPrimaryColor,
                activeTrackColor: kBlack20,
                inactiveThumbColor: kGrey90,
                inactiveTrackColor: kBlack20,
                tileColor: kGrey40,
                value: widget.dept,
                onChanged: (bool value) {
                  setState(() {
                    widget.dept = value;
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
