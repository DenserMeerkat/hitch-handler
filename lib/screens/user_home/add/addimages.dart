// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// Project imports:
import 'package:hitch_handler/screens/components/customfields/customelevatedbutton.dart';
import '../../../constants.dart';
import '../../../resources/post_methods.dart';
import '../../components/customfields/fieldlabel.dart';
import 'imagesource.dart';

class AddImages extends StatefulWidget {
  final bool addImageEnabled;
  final bool viewImagesEnabled;
  const AddImages({
    super.key,
    required this.addImageEnabled,
    required this.viewImagesEnabled,
  });

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  late List<File> galleryList = gengallList();
  late bool addImageEnabled = widget.addImageEnabled;
  late bool viewImagesEnabled = widget.viewImagesEnabled;
  Future<bool?> showImageSources() async {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    return await showModalBottomSheet<bool>(
        backgroundColor: isDark ? kGrey30 : kLBlack15,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        context: context,
        builder: (context) {
          return const ImageSourceSelect();
        });
  }

  List<File> gengallList() {
    int lent = UploadFileList.currLength();
    List<File> list = [];
    for (var i = 0; i < lent; i++) {
      list.add(UploadFileList.retrieveFile(i));
    }
    return list;
  }

  List<Widget> genList() {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    int lent = UploadFileList.currLength();
    List<Widget> list = List<Widget>.filled(
        5,
        GestureDetector(
          onTap: () async {
            await showImageSources();
            updateButtons();
          },
          child: Icon(
            Icons.image,
            color: isDark ? kBlack20 : kLGrey50,
            size: 90,
          ),
        ),
        growable: false);
    for (var i = 0; i < lent; i++) {
      list[i] = ImageThumbnail(
        index: i,
        galleryList: galleryList,
        delete: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (_) => GalleryWidget(
              editMode: true,
              imageList: galleryList,
              index: i,
            ),
          ))
              .then((_) {
            debugPrint("Img Tapped");
            updateButtons();
          });
        },
      );
    }
    return list;
  }

  void updateButtons() {
    setState(() {
      galleryList = gengallList();
      if (UploadFileList.currLength() > 0) {
        viewImagesEnabled = true;
      } else {
        viewImagesEnabled = false;
      }
      if (UploadFileList.currLength() < 5) {
        addImageEnabled = true;
      } else {
        addImageEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(
            fgcolor: isDark ? kPrimaryColor : kLPrimaryColor,
            title: "Add Image",
            bgcolor: isDark ? kBlack15 : kGrey30,
            tooltip: 'tooltip'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
          decoration: BoxDecoration(
            color: isDark ? kGrey50 : kLBlack10,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2.5),
                color: isDark ? kBlack20 : kGrey150,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: isDark ? kGrey40 : kLBlack20,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        color: isDark ? kGrey30 : kLGrey50,
                      )
                    ]),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: genList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButtonWithIcon(
                        onPressed: addImageEnabled
                            ? () async {
                                await showImageSources();
                                updateButtons();
                              }
                            : null,
                        label: "Add",
                        icon: Icons.add_photo_alternate_rounded,
                        activeColor: isDark
                            ? kPrimaryColor.withOpacity(0.8)
                            : kLPrimaryColor.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: ElevatedButtonWithIcon(
                        onPressed: viewImagesEnabled
                            ? () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (_) => GalleryWidget(
                                    editMode: true,
                                    imageList: galleryList,
                                    index: 0,
                                  ),
                                ))
                                    .then((_) {
                                  setState(() {});
                                  updateButtons();
                                });
                              }
                            : null,
                        label: "View",
                        icon: Icons.open_with_rounded,
                        activeColor: kStudentColor.withOpacity(0.8).withRed(30),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ImageThumbnail extends StatelessWidget {
  const ImageThumbnail({
    super.key,
    required this.index,
    required this.galleryList,
    required this.delete,
  });
  final List<File> galleryList;
  final int index;
  final void Function()? delete;

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 5,
            color: isDark ? kBlack20 : kGrey90,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: delete,
          child: Image.file(
            UploadFileList.retrieveFile(index),
            height: 75,
            width: 75,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<File> imageList;
  final int index;
  final bool editMode;
  GalleryWidget({
    super.key,
    required this.imageList,
    this.editMode = false,
    this.index = 0,
  }) : pageController = PageController(initialPage: index);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  int currIndex = 0;
  @override
  void initState() {
    currIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? kGrey40 : kLGrey40,
      appBar: AppBar(
        backgroundColor: isDark ? kBackgroundColor : kLBlack20,
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: IconButton(
                  splashColor: splash(isDark),
                  focusColor: splash(isDark),
                  highlightColor: splash(isDark),
                  hoverColor: splash(isDark),
                  style: AdaptiveTheme.of(context).theme.iconButtonTheme.style,
                  icon: Icon(
                    Icons.close,
                    color: isDark ? kTextColor : kLTextColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  tooltip: "Exit",
                ),
              ),
            );
          },
        ),
        title: Text(
          "Image  [ ${currIndex + 1}/${widget.imageList.length} ]",
          style: TextStyle(
            color: isDark ? kTextColor : kLTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 2,
            color: isDark ? kGrey40 : kLGrey40,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PhotoViewGallery.builder(
            backgroundDecoration: BoxDecoration(
                color: isDark ? kBackgroundColor : kLBackgroundColor),
            pageController: widget.pageController,
            itemCount: widget.imageList.length,
            builder: (context, index) {
              final image = widget.imageList[index];
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(image),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
              );
            },
            onPageChanged: (index) => setState(() {
              currIndex = index;
            }),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding:
            const EdgeInsets.only(top: 10, left: 10, bottom: 15.0, right: 10),
        decoration: BoxDecoration(
          color: isDark ? kBackgroundColor : kLBlack20,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              color: isDark ? kGrey40 : kLGrey40,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imgControlButtons(
              currIndex != 0
                  ? isDark
                      ? kGrey40
                      : kLGrey40
                  : isDark
                      ? kGrey30
                      : kLGrey30,
              currIndex != 0
                  ? () {
                      widget.pageController.previousPage(
                          duration: const Duration(microseconds: 10),
                          curve: Curves.bounceInOut);
                    }
                  : null,
              Icons.arrow_back_ios_new_rounded,
            ),
            widget.editMode
                ? deleteBox(context)
                : const SizedBox(
                    height: 0,
                  ),
            imgControlButtons(
              currIndex != 0
                  ? isDark
                      ? kGrey40
                      : kLGrey40
                  : isDark
                      ? kGrey30
                      : kLGrey30,
              currIndex != widget.imageList.length - 1
                  ? () {
                      widget.pageController.nextPage(
                          duration: const Duration(microseconds: 100),
                          curve: Curves.bounceInOut);
                    }
                  : null,
              Icons.arrow_forward_ios_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Container imgControlButtons(Color bg, void Function()? op, IconData icon) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bg,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: IconButton(
            splashRadius: 33,
            color: isDark ? kTextColor : kLTextColor,
            disabledColor: isDark ? kGrey50 : kLGrey70,
            onPressed: op,
            icon: Icon(
              icon,
            )),
      ),
    );
  }

  Widget deleteBox(BuildContext context) {
    return ElevatedButtonWithIcon(
      onPressed: () {
        setState(() {
          debugPrint(UploadFileList.deleteFile(currIndex));
          widget.imageList.remove(widget.imageList[currIndex]);
          Navigator.pop(context);
        });
      },
      label: 'Delete',
      icon: Icons.delete_forever_rounded,
      activeColor: kErrorColor.withOpacity(0.8),
      borderColor: Colors.transparent,
      borderRadius: 5,
    );
  }
}
