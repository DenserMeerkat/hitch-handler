// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/resources/firestore_methods.dart';
import 'package:hitch_handler/screens/common/post_page.dart';

class PostInfo extends StatefulWidget {
  const PostInfo({
    super.key,
    required this.location,
    required this.date,
    required this.time,
    required this.widget,
    required this.isAuthority,
  });

  final String? location;
  final String? date;
  final String? time;
  final dynamic widget;
  final bool isAuthority;

  @override
  State<PostInfo> createState() => _PostInfoState();
}

class _PostInfoState extends State<PostInfo> {
  String? location;
  @override
  void initState() {
    location = widget.location == "" ? null : widget.location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    var bodyMedium2 =
        AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.copyWith(
              fontSize: 12,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? kTextColor.withOpacity(0.8)
                  : kLTextColor.withOpacity(0.8),
            );
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 20, bottom: 4),
      child: location != null || widget.time != null || widget.date != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      location != null
                          ? Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                location!,
                                style: bodyMedium2,
                              ),
                            )
                          : const SizedBox(),
                      widget.date == null || location == null || location == ""
                          ? const SizedBox()
                          : Text(
                              "•",
                              style: bodyMedium2,
                            ),
                      widget.date != null
                          ? Padding(
                              padding: location == null || location == ""
                                  ? const EdgeInsets.only(right: 8.0)
                                  : const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                widget.date!,
                                style: bodyMedium2,
                              ),
                            )
                          : const SizedBox(),
                      widget.time == null ||
                              widget.location == '' && widget.date == null
                          ? const SizedBox()
                          : Text(
                              "•",
                              style: bodyMedium2,
                            ),
                      widget.time != null
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                widget.time!,
                                style: bodyMedium2,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}

class ActionButtons extends StatefulWidget {
  final dynamic snap;
  final dynamic user;
  final bool showOpen;
  final bool isAuthority;
  const ActionButtons({
    super.key,
    required this.snap,
    required this.user,
    this.showOpen = true,
    required this.isAuthority,
  });

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool isUpVoted = false;
  late int upVoteCount;
  late dynamic snapp;
  bool isBookmarked = false;
  late dynamic sub;
  bool likeProcessing = false;
  bool bookmarkProcessing = false;
  @override
  void initState() {
    isUpVoted = widget.snap['upVotes'].contains(widget.user.uid) ? true : false;
    //upVoteCount = widget.snap['upVoteCount'];
    upVoteCount = widget.snap['upVotes'].length;
    isBookmarked =
        widget.snap['bookmarks'].contains(widget.user.uid) ? true : false;
    var collection = FirebaseFirestore.instance.collection('posts');
    sub =
        collection.doc(widget.snap['postId']).snapshots().listen((docSnapshot) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (docSnapshot.exists && mounted) {
          Map<String, dynamic> data = docSnapshot.data()!;
          isUpVoted = data['upVotes'].contains(widget.user.uid) ? true : false;
          isBookmarked =
              data['bookmarks'].contains(widget.user.uid) ? true : false;
          //upVoteCount = data['upVoteCount'];
          upVoteCount = data['upVotes'].length;
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      setState(() {
        likeProcessing = true;
      });
      String res = "";
      try {
        res = await FirestoreMethods().upVotePost(
            widget.snap['postId'], widget.user.uid, widget.snap['upVotes']);
      } catch (err) {
        res = "$err";
        debugPrint(res);
        return isLiked;
      }
      setState(() {
        likeProcessing = false;
      });
      return !isLiked;
    }

    Future<bool> onBookmarkTapped(bool isLiked) async {
      String res = "";
      setState(() {
        bookmarkProcessing = true;
      });
      bool success = false;
      try {
        res = await FirestoreMethods().bookmarkPost(
            widget.snap['postId'], widget.user.uid, widget.snap['bookmarks']);
      } catch (err) {
        res = "$err";
        return isLiked;
      }
      if (res == "success") {
        success = true;
      }
      setState(() {
        bookmarkProcessing = false;
      });
      return success ? !isLiked : isLiked;
    }

    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    Widget commentCount() {
      //Todo
      return Text(
        "0",
        style: TextStyle(
          color: isDark
              ? kTextColor.withOpacity(0.8)
              : kLTextColor.withOpacity(0.8),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              color: isDark ? kGrey30 : kLBlack20,
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(color: isDark ? kGrey40 : kLGrey30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LikeButton(
                  size: 20.sp,
                  countPostion: CountPostion.right,
                  likeCountPadding: EdgeInsets.only(left: 6.w, right: 6.w),
                  animationDuration: const Duration(milliseconds: 200),
                  likeCountAnimationDuration: const Duration(milliseconds: 200),
                  circleColor: const CircleColor(
                      start: Color(0xff0099cc), end: kPrimaryColor),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: kPrimaryColor,
                    dotSecondaryColor: Color(0xff0099cc),
                  ),
                  isLiked: isUpVoted,
                  likeBuilder: (bool isUpVoted) {
                    return Icon(
                      isUpVoted
                          ? MdiIcons.fromString("arrow-up-bold")
                          : MdiIcons.fromString("arrow-up-bold-outline"),
                      color: isUpVoted
                          ? kPrimaryColor
                          : isDark
                              ? kTextColor.withOpacity(0.7)
                              : kLTextColor.withOpacity(0.7),
                      size: isUpVoted ? 22.sp : 20.sp,
                    );
                  },
                  likeCount: upVoteCount,
                  countBuilder: (likeCount, isLiked, text) {
                    return Text(
                      "$likeCount",
                      style: TextStyle(
                        color: isLiked
                            ? kPrimaryColor
                            : isDark
                                ? kTextColor.withOpacity(0.7)
                                : kLTextColor.withOpacity(0.7),
                      ),
                    );
                  },
                  onTap: !likeProcessing ? onLikeButtonTapped : null,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(6, 0, 2, 0),
                  height: 33,
                  width: 1,
                  color: isDark ? kGrey50 : kLGrey30,
                ),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: "Not implemented yet",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.SNACKBAR,
                        timeInSecForIosWeb: 1,
                        backgroundColor: isDark ? kGrey40 : kLBlack10,
                        textColor: isDark ? kTextColor : kLTextColor,
                        fontSize: 14.0);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.chat_outlined,
                          color: isDark
                              ? kTextColor.withOpacity(0.7)
                              : kLTextColor.withOpacity(0.7),
                          size: 20.sp,
                        ),
                        //SizedBox(width: 8.w),
                        //commentCount(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          widget.showOpen
              ? Tooltip(
                  message: "View Post",
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      final args =
                          PostsArguments(widget.snap, widget.isAuthority);
                      Navigator.pushNamed(context, PostsPage.routeName,
                          arguments: args);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Icon(
                        Icons.open_in_new,
                        color: isDark
                            ? kTextColor.withOpacity(0.7)
                            : kLTextColor.withOpacity(0.7),
                        size: 20.sp,
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  width: 0,
                ),
          const Spacer(),
          widget.snap['status'] == "Closed" &&
                  widget.user.uid == widget.snap['uid']
              ? SizedBox(
                  height: 30,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      foregroundColor: MaterialStatePropertyAll(
                          isDark ? kPrimaryColor : kLTextColor),
                    ),
                    onPressed: () {}, // Todo
                    child: const Text("Satisfied ?"),
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          LikeButton(
            size: 20.sp,
            animationDuration: const Duration(milliseconds: 300),
            likeCountAnimationDuration: const Duration(milliseconds: 300),
            circleColor:
                const CircleColor(start: Color(0xff00ddff), end: kErrorColor),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: kErrorColor,
              dotSecondaryColor: Color(0xff0099cc),
            ),
            isLiked: isBookmarked,
            onTap: !bookmarkProcessing ? onBookmarkTapped : null,
            likeBuilder: (bool isBookmarked) {
              return Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
                color: isBookmarked
                    ? kErrorColor
                    : isDark
                        ? kTextColor.withOpacity(0.7)
                        : kLTextColor.withOpacity(0.7),
                size: 20.sp,
              );
            },
          ),
        ],
      ),
    );
  }
}

class PostTimeAgo extends StatelessWidget {
  const PostTimeAgo({
    super.key,
    required this.timeAgo,
    required this.isAuthority,
  });

  final bool isAuthority;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Posted $timeAgo",
            style:
                AdaptiveTheme.of(context).theme.textTheme.bodySmall!.copyWith(
                      color: isDark
                          ? kTextColor.withOpacity(0.5)
                          : kLTextColor.withOpacity(0.8),
                      fontSize: 11.sp,
                      letterSpacing: 0.5,
                    ),
          ),
        ],
      ),
    );
  }
}
