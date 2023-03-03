import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/screens/components/post_page.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../resources/firestore_methods.dart';
import 'postcard.dart';
import '../../../constants.dart';

class PostInfo extends StatelessWidget {
  const PostInfo({
    super.key,
    required this.location,
    required this.date,
    required this.time,
    required this.widget,
  });

  final String location;
  final String date;
  final String time;
  final dynamic widget;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    location != "" ? location : "Location",
                    style: bodyMedium2,
                  ),
                ),
                const Text("•"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    date,
                    style: bodyMedium2,
                  ),
                ),
                const Text("•"),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    time,
                    style: bodyMedium2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatefulWidget {
  final dynamic snap;
  final dynamic user;
  final bool showOpen;
  const ActionButtons({
    super.key,
    required this.snap,
    required this.user,
    this.showOpen = true,
  });

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool isUpVoted = false;
  int upVoteCount = 0;

  bool isBookmarked = false;
  @override
  void initState() {
    isUpVoted = widget.snap['upVotes'].contains(widget.user.uid) ? true : false;
    upVoteCount = widget.snap['upVotes'].length;
    isBookmarked =
        widget.user.bookmarks.contains(widget.snap['postId']) ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      String res = "";
      bool success = false;
      try {
        res = await FirestoreMethods().upVotePost(
            widget.snap['postId'], widget.user.uid, widget.snap['upVotes']);
      } catch (err) {
        res = "$err";
        return isLiked;
      }
      if (res == "success") {
        success = true;
      }
      return success ? !isLiked : isLiked;
    }

    Future<bool> onBookmarkTapped(bool isLiked) async {
      String res = "";
      bool success = false;
      try {
        res = await FirestoreMethods().bookmarkPost(
            widget.snap['postId'], widget.user.uid, widget.user.bookmarks);
      } catch (err) {
        res = "$err";
        return isLiked;
      }
      if (res == "success") {
        success = true;
      }
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
                  animationDuration: const Duration(milliseconds: 500),
                  likeCountAnimationDuration: const Duration(milliseconds: 500),
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
                      // shadows: [
                      //   BoxShadow(
                      //       offset: const Offset(1, 1),
                      //       color: isDark ? Colors.transparent : kLGrey30,
                      //       blurRadius: 5)
                      // ],
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
                  onTap: onLikeButtonTapped,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(6, 0, 2, 0),
                  height: 33,
                  width: 1,
                  color: isDark ? kGrey50 : kLGrey30,
                ),
                InkWell(
                  onTap: () {},
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
                          // shadows: [
                          //   BoxShadow(
                          //       offset: const Offset(1, 1),
                          //       color: isDark ? Colors.transparent : kLGrey30,
                          //       blurRadius: 5)
                          // ],
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        commentCount(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          widget.showOpen
              ? InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    final args = PostsArguments(widget.snap);
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
                      // shadows: [
                      //   BoxShadow(
                      //       offset: const Offset(1, 1),
                      //       color: isDark ? Colors.transparent : kLGrey30,
                      //       blurRadius: 5)
                      // ],
                    ),
                  ),
                )
              : const SizedBox(
                  width: 0,
                ),
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
            onTap: onBookmarkTapped,
            likeBuilder: (bool isBookmarked) {
              return Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
                color: isBookmarked
                    ? kErrorColor
                    : isDark
                        ? kTextColor.withOpacity(0.7)
                        : kLTextColor.withOpacity(0.7),
                size: 20.sp,
                // shadows: [
                //   BoxShadow(
                //       offset: const Offset(1, 1),
                //       color: isDark ? Colors.transparent : kLGrey40,
                //       blurRadius: 5)
                // ],
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
    required this.isDark,
  });

  final String timeAgo;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
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
