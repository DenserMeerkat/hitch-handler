import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../components/customfields/customelevatedbutton.dart';
import '../../components/customfields/fieldlabel.dart';
import '../../../constants.dart';
import 'addpostbrain.dart';
import 'imagesource.dart';

class AddImages extends StatefulWidget {
  bool addImageEnabled;
  bool viewImagesEnabled;
  AddImages({
    super.key,
    required this.addImageEnabled,
    required this.viewImagesEnabled,
  });

  @override
  State<AddImages> createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  late List<File> galleryList = gengallList();

  Future<bool?> showImageSources() async {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    return await showModalBottomSheet<bool>(
        backgroundColor: kGrey30,
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
    int lent = UploadFileList.currLength();
    List<Widget> list = List<Widget>.filled(
        5,
        const Icon(
          Icons.image,
          color: kBlack20,
          size: 90,
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
        widget.viewImagesEnabled = true;
      } else {
        widget.viewImagesEnabled = false;
      }
      if (UploadFileList.currLength() < 5) {
        widget.addImageEnabled = true;
      } else {
        widget.addImageEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(
            fgcolor: kPrimaryColor,
            title: "Add Image",
            bgcolor: kBlack15,
            tooltip: 'tooltip'),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
          decoration: const BoxDecoration(
              color: kGrey50,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
                  color: kBlack20,
                )
              ]),
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
                    color: kGrey40,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        color: kGrey30,
                      )
                    ]),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
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
                        onPressed: widget.addImageEnabled
                            ? () async {
                                final bool? shouldRefresh =
                                    await showImageSources();
                                updateButtons();
                              }
                            : null,
                        label: "Add",
                        icon: Icons.add_photo_alternate_rounded,
                        activeColor: kPrimaryColor.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: ElevatedButtonWithIcon(
                        onPressed: widget.viewImagesEnabled
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
    void openGallery() => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GalleryWidget(
            editMode: false,
            imageList: galleryList,
            index: index,
          ),
        ));
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 5,
            color: kBlack20,
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
  bool editMode;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGrey30,
        title: Text(
          "Image  [ ${currIndex + 1}/${widget.imageList.length} ]",
          style: const TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PhotoViewGallery.builder(
            backgroundDecoration: const BoxDecoration(color: kBackgroundColor),
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
        color: kGrey30,
        padding:
            const EdgeInsets.only(top: 10, left: 10, bottom: 15.0, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kGrey50,
              ),
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                    splashRadius: 40,
                    color: kTextColor,
                    disabledColor: kBlack20,
                    onPressed: currIndex != 0
                        ? () {
                            widget.pageController.previousPage(
                                duration: const Duration(microseconds: 10),
                                curve: Curves.bounceInOut);
                          }
                        : null,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    )),
              ),
            ),
            widget.editMode
                ? deleteBox(context)
                : const SizedBox(
                    height: 0,
                  ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kGrey50,
              ),
              child: Material(
                type: MaterialType.transparency,
                child: IconButton(
                    splashRadius: 40,
                    color: kTextColor,
                    disabledColor: kBlack20,
                    onPressed: currIndex != widget.imageList.length - 1
                        ? () {
                            widget.pageController.nextPage(
                                duration: const Duration(microseconds: 100),
                                curve: Curves.bounceInOut);
                          }
                        : null,
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container deleteBox(BuildContext context) {
    return Container(
      child: ElevatedButtonWithIcon(
        onPressed: () {
          setState(() {
            debugPrint(UploadFileList.deleteFile(currIndex));
            widget.imageList.remove(currIndex);
            Navigator.pop(context);
          });
        },
        label: 'Delete',
        icon: Icons.delete_forever_rounded,
        activeColor: kErrorColor,
        borderColor: Colors.transparent,
        borderRadius: 5,
      ),
    );
  }
}
