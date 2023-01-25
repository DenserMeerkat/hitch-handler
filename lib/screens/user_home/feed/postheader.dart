import 'package:flutter/material.dart';
import 'postcard.dart';
import '../../../constants.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({
    super.key,
    required this.widget,
  });

  final PostCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 30, bottom: 10),
      child: Text(
        widget.snap['title'],
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20,
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
    required this.timeAgo,
  });

  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
      ),
      child: Row(
        children: [
          Text(
            "Posted $timeAgo",
            style: TextStyle(
              fontSize: 14,
              //letterSpacing: 0.1,
              //fontWeight: FontWeight.bold,
              color: kTextColor.withOpacity(0.6),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor, width: 2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "In \tReview",
              style: TextStyle(
                color: kTextColor.withOpacity(0.9),
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              splashRadius: 20,
              icon: const Icon(
                Icons.more_vert_rounded,
                color: kTextColor,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
