// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/models/user.dart' as model;
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/screens/common/post_page.dart';
import 'package:hitch_handler/screens/components/utils/statusdialog.dart';
import 'package:hitch_handler/screens/components/utils/statuslogdialog.dart';

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
    this.isAuthority = false,
    this.isViewPage = false,
  });
  final dynamic snap;
  final bool isAuthority;
  final bool isViewPage;

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
  String? satisfied;
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
        try {
          satisfied = data['satisfied'];
        } catch (err) {
          satisfied = null;
          debugPrint(err.toString());
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
    try {
      satisfied = widget.snap['satisfied'];
    } catch (err) {
      satisfied = null;
      debugPrint(err.toString());
    }
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
    model.User? user = Provider.of<UserProvider>(context).getUser;
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
          satisfied != null
              ? satisfied == 'Yes'
                  ? Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      message: "User Satisfied",
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color:
                                isDark ? kGrey30 : kLBlack15.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: isDark ? kGrey40 : kLGrey30)),
                        child: const Icon(
                          Icons.thumb_up_alt,
                          color: kPrimaryColor,
                          size: 14,
                        ),
                      ),
                    )
                  : Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      message: "User not Satisfied",
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color:
                                isDark ? kGrey30 : kLBlack15.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(50),
                            border:
                                Border.all(color: isDark ? kGrey40 : kLGrey30)),
                        child: Icon(
                          Icons.thumb_down_alt,
                          color: isDark
                              ? AdaptiveTheme.of(context)
                                  .theme
                                  .colorScheme
                                  .error
                              : kErrorColor,
                          size: 14,
                        ),
                      ),
                    )
              : Container(),
          const SizedBox(width: 8),
          widget.isAuthority
              ? PopupMenuButton(
                  color: isDark ? kGrey40 : kLBlack10,
                  surfaceTintColor: isDark ? kGrey40 : kLBlack10,
                  splashRadius: 25.0,
                  offset: Offset(8.w, 4),
                  position: PopupMenuPosition.under,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  icon: SizedBox(
                    width: 80.w,
                    child: Status(
                      statusIcon: statusIcon,
                      statusText: widget.snap['status'],
                      statusColor: statusColor,
                    ),
                  ),
                  itemBuilder: (context) {
                    final bool isDark =
                        AdaptiveTheme.of(context).brightness == Brightness.dark;
                    return [
                      PopupMenuItem<int>(
                        height: 20,
                        onTap: () {
                          Future.delayed(
                            const Duration(seconds: 0),
                            () => showDialog(
                              context: context,
                              useSafeArea: false,
                              builder: (BuildContext context) {
                                return StatusDialog(
                                  statusIndex: statusIndex,
                                  snap: widget.snap,
                                  user: user,
                                );
                              },
                            ),
                          );
                        },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        value: 0,
                        child: Text(
                          "Update Status",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? kTextColor : kLTextColor,
                          ),
                        ),
                      ),
                      PopupMenuItem<int>(
                        height: 20,
                        enabled: !widget.isViewPage,
                        onTap: () {
                          debugPrint('${widget.isViewPage}');
                          Future.delayed(const Duration(seconds: 0), () {
                            final args =
                                PostsArguments(widget.snap, widget.isAuthority);
                            Navigator.pushNamed(context, PostsPage.routeName,
                                arguments: args);
                          }
                              //  =>showDialog(
                              //   context: context,
                              //   useSafeArea: false,
                              //   builder: (BuildContext context) {
                              //     return StatusLogDialog(
                              //       statusIndex: statusIndex,
                              //       snap: widget.snap,
                              //       user: user,
                              //     );
                              //   },
                              // ),
                              );
                        },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        value: 1,
                        child: Text(
                          "View Logs",
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.isViewPage
                                ? isDark
                                    ? kTextColor.withOpacity(0.5)
                                    : kLTextColor.withOpacity(0.7)
                                : isDark
                                    ? kTextColor
                                    : kLTextColor,
                          ),
                        ),
                      ),
                    ];
                  },
                )
              : Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: !widget.isViewPage
                        ? () {
                            final args =
                                PostsArguments(widget.snap, widget.isAuthority);
                            Navigator.pushNamed(context, PostsPage.routeName,
                                arguments: args);
                            // showDialog(
                            //   context: context,
                            //   useSafeArea: false,
                            //   builder: (BuildContext context) {
                            //     return StatusLogDialog(
                            //       statusIndex: statusIndex,
                            //       snap: widget.snap,
                            //       user: user,
                            //     );
                            //   },
                            // );
                          }
                        : null,
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
