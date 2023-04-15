// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';

class FeedSkeleton extends StatelessWidget {
  final bool hasAppbar;
  const FeedSkeleton({super.key, this.hasAppbar = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          hasAppbar
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16),
                  child: Row(
                    children: [
                      const ShimmerBox(
                        height: 24,
                        width: 24,
                        bradius: 50,
                      ),
                      const Spacer(),
                      ShimmerBox(
                        height: 28,
                        width: 75.w,
                        bradius: 50,
                      ),
                      SizedBox(width: 16.w),
                      ShimmerBox(
                        height: 28,
                        width: 40.w,
                        bradius: 50,
                      ),
                    ],
                  ),
                )
              : Container(),
          const PostSkeleton(),
          const PostSkeleton(hasImage: true),
          const PostSkeleton()
        ],
      ),
    );
  }
}

class StatusTileSkeleton extends StatelessWidget {
  const StatusTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? kGrey30 : kLBlack15,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? kGrey50 : kLBlack20, width: 2),
      ),
      child: const ListTile(
        dense: true,
        leading: ShimmerBox(
          height: 30,
          width: 30,
          bradius: 50,
        ),
        title: ShimmerBox(
          height: 16,
          width: 60,
          bradius: 50,
        ),
        subtitle: ShimmerBox(
          height: 16,
          width: 100,
          bradius: 50,
        ),
        trailing: ShimmerBox(
          height: 24,
          width: 24,
          bradius: 50,
        ),
      ),
    );
  }
}

class PostSkeleton extends StatelessWidget {
  final bool hasImage;
  const PostSkeleton({super.key, this.hasImage = false});

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      constraints: BoxConstraints(
        minHeight: 150.h,
      ),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? kGrey30.withOpacity(0.5) : kLBackgroundColor,
        border: Border(
          top: BorderSide(color: isDark ? kGrey40 : kLGrey30),
          bottom: BorderSide(color: isDark ? kGrey40 : kLGrey30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8),
            child: Row(
              children: const [
                ShimmerBox(
                  height: 20,
                  width: 100,
                ),
                Spacer(),
                ShimmerBox(
                  height: 22,
                  width: 90,
                  bradius: 50,
                ),
                SizedBox(width: 16),
                ShimmerBox(
                  height: 24,
                  width: 24,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerBox(
                  height: 12,
                  width: 200,
                ),
                const SizedBox(height: 16),
                ShimmerBox(
                  height: 20,
                  width: 336.w,
                ),
              ],
            ),
          ),
          hasImage
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8),
                  child: Row(
                    children: [
                      ShimmerBox(
                        height: 180.h,
                        width: 336.w,
                        bradius: 4,
                      ),
                    ],
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8),
            child: Row(
              children: const [
                ShimmerBox(
                  height: 20,
                  width: 80,
                  bradius: 50,
                ),
                SizedBox(width: 16),
                ShimmerBox(
                  height: 20,
                  width: 20,
                  bradius: 4,
                ),
                Spacer(),
                ShimmerBox(
                  height: 20,
                  width: 20,
                  bradius: 4,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8),
            child: const ShimmerBox(
              height: 10,
              width: 80,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final double bradius;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.bradius = 2,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? kGrey40 : kLGrey30,
      highlightColor: isDark ? kGrey50 : kLBlack20,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(bradius)),
        child: const Text(''),
      ),
    );
  }
}
