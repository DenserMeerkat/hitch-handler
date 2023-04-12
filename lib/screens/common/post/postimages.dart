import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../constants.dart';

class PostImages extends StatefulWidget {
  const PostImages({
    super.key,
    required this.snap,
    required this.imgList,
  });
  final List<dynamic> imgList;
  final dynamic snap;

  @override
  State<PostImages> createState() => _PostImagesState();
}

class _PostImagesState extends State<PostImages> {
  final PageController pageController = PageController();
  PhotoViewScaleStateController scaleController =
      PhotoViewScaleStateController();
  int currIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scaleController.scaleState = PhotoViewScaleState.covering;
    super.initState();
  }

  PhotoViewScaleState customScaleStateCycle(PhotoViewScaleState actual) {
    switch (actual) {
      case PhotoViewScaleState.initial:
        return PhotoViewScaleState.covering;
      case PhotoViewScaleState.covering:
        return PhotoViewScaleState.initial;
      case PhotoViewScaleState.originalSize:
        return PhotoViewScaleState.initial;
      case PhotoViewScaleState.zoomedIn:
      case PhotoViewScaleState.zoomedOut:
        return PhotoViewScaleState.initial;
      default:
        return PhotoViewScaleState.covering;
    }
    // switch (actual) {
    //   case PhotoViewScaleState.initial:
    //     return PhotoViewScaleState.covering;
    //   case PhotoViewScaleState.covering:
    //     return PhotoViewScaleState.originalSize;
    //   case PhotoViewScaleState.originalSize:
    //     return PhotoViewScaleState.initial;
    //   case PhotoViewScaleState.zoomedIn:
    //   case PhotoViewScaleState.zoomedOut:
    //     return PhotoViewScaleState.initial;
    //   default:
    //     return PhotoViewScaleState.initial;
    // }
  }

  void changeScaleState() {
    debugPrint(scaleController.scaleState.toString());
    setState(() {
      scaleController.scaleState =
          customScaleStateCycle(scaleController.scaleState);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    if (widget.imgList.isNotEmpty) {
      return Container(
        constraints: BoxConstraints(
            maxHeight: 300.w > 320 ? 320 : 300.w, minHeight: 300),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? Colors.black : kLBackgroundColor,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: isDark ? kGrey30 : kLGrey30,
              width: 1,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            PhotoViewGallery.builder(
              wantKeepAlive: true,
              backgroundDecoration: BoxDecoration(
                color: isDark ? Colors.black87 : kLBackgroundColor,
              ),
              pageController: pageController,
              itemCount: widget.imgList.length,
              loadingBuilder:
                  (BuildContext context, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return Container();
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                    backgroundColor: kGrey30,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              builder: (context, index) {
                final image = widget.imgList[index];
                return PhotoViewGalleryPageOptions(
                  basePosition: Alignment.center,
                  disableGestures: true,
                  scaleStateController: scaleController,
                  filterQuality: FilterQuality.high,
                  imageProvider: NetworkImage(image),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 3,
                  scaleStateCycle: customScaleStateCycle,
                );
              },
              onPageChanged: (index) => setState(() {
                currIndex = index;
              }),
            ),
            widget.imgList.length > 1
                ? Container(
                    margin: const EdgeInsets.all(10),
                    padding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 10.w),
                    decoration: BoxDecoration(
                        color: kGrey30.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "${currIndex + 1} / ${widget.imgList.length}",
                      style: const TextStyle(color: kTextColor),
                    ),
                  )
                : const SizedBox(),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: changeScaleState,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: kGrey30.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.fullscreen,
                    color: kTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
