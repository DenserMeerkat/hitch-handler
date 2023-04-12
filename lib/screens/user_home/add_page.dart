import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/components/utils/refreshcomponents.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';
import 'add/addform.dart';
import '../../constants.dart';

class AddPage extends StatefulWidget {
  static String routeName = '/add_page';
  static ScrollController scrollController = ScrollController();
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool loading = false;
  GlobalKey<AddFormState> globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
        globalKey.currentState!.clearForm();
        return false;
      },
      child: Scaffold(
        backgroundColor: isDark ? kBlack20 : kLBlack10,
        appBar: AppBar(
          elevation: 9,
          backgroundColor: isDark ? kBackgroundColor : kLBlack20,
          surfaceTintColor: isDark ? kBackgroundColor : kLBlack20,
          title: Text(
            "Add Post",
            style: AdaptiveTheme.of(context)
                .theme
                .textTheme
                .displayMedium!
                .copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: IconButton(
                    splashColor: isDark
                        ? kTextColor.withOpacity(0.1)
                        : kLTextColor.withOpacity(0.1),
                    focusColor: isDark
                        ? kTextColor.withOpacity(0.1)
                        : kLTextColor.withOpacity(0.1),
                    highlightColor: isDark
                        ? kTextColor.withOpacity(0.1)
                        : kLTextColor.withOpacity(0.1),
                    hoverColor: isDark
                        ? kTextColor.withOpacity(0.1)
                        : kLTextColor.withOpacity(0.1),
                    style:
                        AdaptiveTheme.of(context).theme.iconButtonTheme.style,
                    icon: Icon(
                      Icons.close,
                      color: isDark ? kTextColor : kLTextColor,
                    ),
                    onPressed: () {
                      globalKey.currentState!.clearForm();
                    },
                    tooltip: "Exit",
                  ),
                ),
              );
            },
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  side: MaterialStatePropertyAll(BorderSide(
                    color: isDark ? kGrey50 : kPrimaryColor,
                    width: 1.5,
                  )),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                  ),
                ),
                onPressed: () {
                  globalKey.currentState!.validateForm();
                },
                child: Text(
                  "Post",
                  style: AdaptiveTheme.of(context)
                      .theme
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                        fontSize: 15,
                        color: isDark ? kPrimaryColor : kLTextColor,
                      ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 1.5,
              color: isDark ? kGrey40 : kLGrey40,
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: loading ? const LProgressIndicator() : null,
            ),
            SliverFillRemaining(
              child: Container(
                constraints:
                    const BoxConstraints(minHeight: 300, maxHeight: 2000),
                color: isDark ? kBackgroundColor : kLBlack20,
                child: SingleChildScrollView(
                  controller: AddPage.scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.h),
                      NotificationListener<IsLoading>(
                        child: AddForm(
                          key: globalKey,
                        ),
                        onNotification: (n) {
                          setState(() {
                            loading = n.isLoading;
                          });
                          return true;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
