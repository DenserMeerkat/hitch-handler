import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'postcard.dart';
import '../../../constants.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({
    super.key,
    required this.snap,
  });

  final dynamic snap;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 30.w),
      child: Text(
        snap['title'],
        textAlign: TextAlign.left,
        style:
            AdaptiveTheme.of(context).theme.textTheme.headlineSmall!.copyWith(
                  color: isDark ? kTextColor.withOpacity(0.9) : kLTextColor,
                  fontSize: 18.w,
                  fontWeight: FontWeight.bold,
                ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class PostTop extends StatelessWidget {
  const PostTop({
    super.key,
    required this.snap,
  });
  final dynamic snap;

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
              color: isDark ? kGrey40 : kLGrey30.withOpacity(0.8),
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: isDark ? kGrey50 : kLGrey30,
                width: 0.5,
              ),
            ),
            child: Text(
              snap['domain'],
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor, width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "In Review",
              style: AdaptiveTheme.of(context)
                  .theme
                  .textTheme
                  .titleSmall!
                  .copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              splashRadius: 20.r,
              icon: Icon(
                Icons.more_vert_rounded,
                color: isDark ? kTextColor : kLTextColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class PostDesc extends StatelessWidget {
  const PostDesc({
    super.key,
    required this.snap,
  });

  final dynamic snap;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: ExpandableText(
        snap['description'],
        style: AdaptiveTheme.of(context)
            .theme
            .textTheme
            .bodySmall!
            .copyWith(fontSize: 13),
        prefixStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w600),
        //prefixText: "Author :",
        expandOnTextTap: true,
        collapseOnTextTap: true,
        expandText: 'show more',
        collapseText: ' \tshow less',
        maxLines: 2,
        linkStyle: AdaptiveTheme.of(context)
            .theme
            .textTheme
            .bodyMedium!
            .copyWith(
                fontSize: 13,
                color: isDark ? kTextColor.withOpacity(0.6) : kLTextColor,
                fontWeight: isDark ? FontWeight.normal : FontWeight.bold),
      ),
    );
  }
}
