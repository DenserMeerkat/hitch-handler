// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:hitch_handler/screens/components/utils/postsskeleton.dart';
import 'package:hitch_handler/screens/components/utils/statusdialog.dart';
import '../../../constants.dart';

class StatusObject {
  final int index;
  final Color color;
  final IconData icon;
  final String title;
  const StatusObject({
    required this.index,
    required this.color,
    required this.icon,
    required this.title,
  });
}

class PostTop extends StatefulWidget {
  const PostTop({
    super.key,
    required this.snap,
    required this.isAuthority,
  });
  final dynamic snap;
  final bool isAuthority;

  static List<StatusObject> status = const [
    StatusObject(
        index: 0,
        color: kPrimaryColor,
        icon: Icons.radio_button_checked_rounded,
        title: "In Review"),
    StatusObject(
        index: 1,
        color: kAdminColor,
        icon: Icons.cached_rounded,
        title: "Working"),
    StatusObject(
        index: 2,
        color: kStudentColor,
        icon: Icons.check_circle_outline_rounded,
        title: "Closed"),
  ];

  @override
  State<PostTop> createState() => _PostTopState();
}

class _PostTopState extends State<PostTop> {
  late IconData statusIcon;
  late Color statusColor;
  late int statusIndex;
  late dynamic sub;
  @override
  void initState() {
    var collection = FirebaseFirestore.instance.collection('posts');
    sub =
        collection.doc(widget.snap['postId']).snapshots().listen((docSnapshot) {
      if (docSnapshot.exists && mounted) {
        Map<String, dynamic> data = docSnapshot.data()!;
        switch (data['status']) {
          case "In Review":
            statusIndex = 0;
            break;
          case "Closed":
            statusIndex = 2;
            break;
          case "Working":
            statusIndex = 1;
            break;
          default:
            statusIndex = 0;
        }
        update();
      }
    });
    super.initState();
    switch (widget.snap['status']) {
      case "In Review":
        statusIndex = 0;
        break;
      case "Closed":
        statusIndex = 2;
        break;
      case "Working":
        statusIndex = 1;
        break;
      default:
        statusIndex = 0;
    }
    statusColor = PostTop.status[statusIndex].color;
    statusIcon = PostTop.status[statusIndex].icon;
  }

  void update() {
    if (!mounted) {
      return;
    }
    setState(() {
      statusColor = PostTop.status[statusIndex].color;
      statusIcon = PostTop.status[statusIndex].icon;
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.only(
        left: 12.w,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? kGrey50 : kLBlack20.withOpacity(0.8),
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: isDark ? kGrey50 : kLGrey30,
                width: 0.5,
              ),
            ),
            child: Text(
              widget.snap['domain'],
              style: AdaptiveTheme.of(context)
                  .theme
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                    fontSize: 12.sp,
                  ),
            ),
          ),
          const Spacer(),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                if (widget.isAuthority) {
                  showDialog(
                    context: context,
                    useSafeArea: false,
                    builder: (BuildContext context) {
                      return StatusDialog(statusIndex: statusIndex);
                    },
                  );
                } else {
                  // Todo User Status Dialog
                }
              },
              child: SizedBox(
                width: 80.w,
                child: Status(
                  statusIcon: statusIcon,
                  statusText: widget.snap['status'],
                  statusColor: statusColor,
                ),
              ),
            ),
          ),
          Tooltip(
            message: "Copy Post-Id",
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                    color: isDark ? kGrey30 : kLBlack20,
                    border: Border.all(
                      color: isDark ? kGrey40 : kLGrey30,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      await Clipboard.setData(
                              ClipboardData(text: widget.snap['postId']))
                          .then((value) {
                        // final snackBar = showCustomSnackBar(
                        //   context,
                        //   "Post-Id copied to clipboard",
                        //   () {},
                        //   icon: Icon(
                        //     Icons.link,
                        //     color: isDark ? kTextColor : kLTextColor,
                        //   ),
                        //   borderColor: isDark
                        //       ? kTextColor.withOpacity(0.2)
                        //       : kLTextColor.withOpacity(0.5),
                        //   duration: const Duration(milliseconds: 1200),
                        //   margin: EdgeInsets.symmetric(
                        //       horizontal: 65.w, vertical: 10),
                        // );
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(snackBar)
                        //     .closed
                        //     .then((value) =>
                        //         ScaffoldMessenger.of(context).clearSnackBars());
                        Fluttertoast.showToast(
                            msg: "Post-Id copied to clipboard",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.SNACKBAR,
                            timeInSecForIosWeb: 1,
                            backgroundColor: isDark ? kGrey40 : kLBlack10,
                            textColor: isDark ? kTextColor : kLTextColor,
                            fontSize: 14.0);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        MdiIcons.linkVariant,
                        color: isDark ? kTextColor : kLTextColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Status extends StatelessWidget {
  const Status({
    super.key,
    required this.statusIcon,
    required this.statusColor,
    required this.statusText,
    this.fsize = 10,
  });
  final IconData statusIcon;
  final Color statusColor;
  final String statusText;
  final double fsize;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.4),
        border: Border.all(color: statusColor.withOpacity(0.8), width: 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            statusIcon,
            size: fsize.sp,
            color: isDark ? kTextColor : kLTextColor,
          ),
          const SizedBox(width: 4),
          Text(
            statusText,
            style:
                AdaptiveTheme.of(context).theme.textTheme.titleSmall!.copyWith(
                      color: isDark ? kTextColor : kLTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: fsize.sp,
                    ),
          ),
          const SizedBox(width: 1),
        ],
      ),
    );
  }
}
