import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../models/user.dart' as model;
import '../../../constants.dart';
import '../../../providers/user_provider.dart';
import 'postfooter.dart';
import 'postheader.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    super.key,
    required this.snap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final PageController pageController = PageController();
  PhotoViewScaleStateController scaleController =
      PhotoViewScaleStateController();
  int currIndex = 0;
  List imgList = [];

  late String location;
  late String date;
  late String time;
  late DateTime tempDate;
  late String timeAgo;
  @override
  void dispose() {
    pageController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scaleController.scaleState = PhotoViewScaleState.covering;
    location = widget.snap['location'];
    date = widget.snap['date'];
    time = widget.snap['time'];
    imgList = widget.snap['imgList'];
    tempDate = DateTime.fromMicrosecondsSinceEpoch(
        widget.snap['datePublished'].microsecondsSinceEpoch);
    timeAgo = timeago.format(tempDate);
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      constraints: const BoxConstraints(
        minHeight: 200,
      ),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: kGrey30.withOpacity(0.5),
        border: const Border(
          top: BorderSide(color: kGrey40),
          bottom: BorderSide(color: kGrey40),
        ),
        //borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostTop(timeAgo: timeAgo),
          PostTitle(widget: widget),
          imgList.isNotEmpty
              ? Container(
                  constraints: BoxConstraints(maxHeight: size.height * 0.38),
                  width: double.infinity,
                  color: Colors.black,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      PhotoViewGallery.builder(
                        wantKeepAlive: true,
                        // scaleStateChangedCallback: (value) {
                        //   debugPrint("$value");
                        // },
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.black87,
                        ),
                        pageController: pageController,
                        itemCount: imgList.length,
                        loadingBuilder: (BuildContext context,
                            ImageChunkEvent? loadingProgress) {
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
                          final image = imgList[index];
                          return PhotoViewGalleryPageOptions(
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
                          // scaleController.scaleState =
                          //     PhotoViewScaleState.covering;
                          currIndex = index;
                        }),
                      ),
                      imgList.length > 1
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: kGrey30.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(5)),
                              child:
                                  Text("${currIndex + 1} / ${imgList.length}"),
                            )
                          : const SizedBox(),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: changeScaleState,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
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
                )
              : const SizedBox(),
          ActionButtons(
            snap: widget.snap,
            user: user,
          ),
          PostInfo(location: location, date: date, time: time, widget: widget),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Text(
              "$timeAgo",
              style: TextStyle(
                fontSize: 11,
                //letterSpacing: 0.1,
                //fontWeight: FontWeight.bold,
                color: kTextColor.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeScaleState() {
    debugPrint(scaleController.scaleState.toString());
    setState(() {
      scaleController.scaleState =
          customScaleStateCycle(scaleController.scaleState);
    });
  }
}
