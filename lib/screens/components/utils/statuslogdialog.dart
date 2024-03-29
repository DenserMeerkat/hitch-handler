// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/common/post/posttop.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/screens/components/utils/skeletons.dart';
import 'package:hitch_handler/screens/components/utils/tiles.dart';

class StatusLogDialog extends StatefulWidget {
  final int statusIndex;
  final dynamic snap;
  final dynamic user;
  const StatusLogDialog(
      {super.key,
      required this.statusIndex,
      required this.snap,
      required this.user});
  @override
  State<StatusLogDialog> createState() => _StatusLogDialogState();
}

class _StatusLogDialogState extends State<StatusLogDialog> {
  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();
  final List<DocumentSnapshot> logs = [];
  bool _isRequesting = false;
  @override
  void initState() {
    super.initState();
    requestNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: isDark ? kGrey40 : kLBlack10,
      surfaceTintColor: isDark ? kGrey40 : kLBlack10,
      scrollable: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const FittedBox(
            child: Icon(
              Icons.storage_outlined,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Status Logs",
            style:
                AdaptiveTheme.of(context).theme.textTheme.bodyLarge!.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 400.h),
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: streamController.stream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                if (_isRequesting ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        height: 2,
                        color: isDark
                            ? kTextColor.withOpacity(0.2)
                            : kLTextColor.withOpacity(0.2),
                      ),
                      const SizedBox(height: 16),
                      const StatusTileSkeleton(),
                      const StatusTileSkeleton(),
                    ],
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(
                          height: 2,
                          color: isDark
                              ? kTextColor.withOpacity(0.2)
                              : kLTextColor.withOpacity(0.2),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                isDark ? kGrey30 : kLBlack15.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: isDark ? kGrey50 : kLBlack20, width: 2),
                          ),
                          child: ListTile(
                            dense: true,
                            leading: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Icon(
                                Icons.radio_button_checked,
                                size: 20,
                                color: isDark ? kTextColor : kLTextColor,
                              ),
                            ),
                            title: Text(
                              "In Review",
                              style: TextStyle(
                                  color: isDark ? kTextColor : kLTextColor,
                                  fontSize: 14,
                                  letterSpacing: 1),
                            ),
                            subtitle: Text(
                              "<First Log>",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? kTextColor.withOpacity(0.7)
                                      : kLTextColor.withOpacity(0.7)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                List<Widget> list = [];
                for (int index = 0; index < snapshot.data!.length; index += 1) {
                  dynamic snap = snapshot.data![index].data();
                  int statusIndex = snap['newStatus'] == "In Review"
                      ? 0
                      : snap['newStatus'] == "Working"
                          ? 1
                          : 2;
                  IconData leading = PostTop.status[statusIndex].icon;
                  Color iconColor = PostTop.status[statusIndex].color;
                  String statusTitle = PostTop.status[statusIndex].title;
                  list.add(
                    StatusTile(
                      index: index,
                      isDark: isDark,
                      iconColor: iconColor,
                      leading: leading,
                      statusTitle: statusTitle,
                      snap: snap,
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        height: 2,
                        color: isDark
                            ? kTextColor.withOpacity(0.2)
                            : kLTextColor.withOpacity(0.2),
                      ),
                      const SizedBox(height: 8),
                      ...list
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      actions: [
        buildActiveButton(
          context,
          true,
          "Exit",
          () {
            Navigator.of(context).pop();
          },
        )
      ],
      actionsPadding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
    );
  }

  void requestNextPage() async {
    QuerySnapshot querySnapshot;
    _isRequesting = true;

    querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.snap['postId'])
        .collection('comments')
        .orderBy('datePublished', descending: true)
        .get();

    logs.addAll(querySnapshot.docs);
    streamController.add(logs);
    setState(() {
      _isRequesting = false;
    });
  }
}
