import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../common/post/postcard.dart';
import '../../constants.dart';
import '../../models/user.dart' as model;

class AuthArchivesPage extends StatefulWidget {
  const AuthArchivesPage({super.key});

  @override
  State<AuthArchivesPage> createState() => _AuthArchivesPageState();
}

class _AuthArchivesPageState extends State<AuthArchivesPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    addData();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    //Size size = MediaQuery.of(context).size; // Available screen size
    final bool isDark =
        AdaptiveTheme.of(context).brightness == Brightness.dark ? true : false;
    return Scaffold(
      backgroundColor: isDark ? Colors.transparent : kLBlack20,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? Colors.transparent : kLBlack20,
        surfaceTintColor: isDark ? Colors.transparent : kLBlack20,
        elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            padding: EdgeInsets.only(
              top: 10.0.h,
              left: 70.w,
              right: 70.w,
              bottom: 14.0.h,
            ),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: isDark ? kGrey40 : kLGrey40)),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(
                  color: isDark ? kGrey40 : kLGrey40,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Container(
                  color: isDark ? kGrey30 : kLBlack10,
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorWeight: 0.0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: kBlack10,
                    unselectedLabelColor: isDark
                        ? kTextColor.withOpacity(0.8)
                        : kLTextColor.withOpacity(0.8),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12.sp,
                      letterSpacing: 0.5,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      letterSpacing: 0.5,
                    ),
                    splashBorderRadius: BorderRadius.circular(50.r),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: isDark
                          ? kPrimaryColor.withOpacity(0.9)
                          : kLPrimaryColor.withOpacity(0.8),
                      border: Border.all(
                        color: isDark ? kPrimaryColor : kLPrimaryColor,
                        width: 2,
                      ),
                    ),
                    controller: _tabController,
                    tabs: const <Widget>[
                      Tab(
                        text: "Your Posts",
                      ),
                      Tab(
                        text: "Bookmarks",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LimitedBox(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('uid', isEqualTo: user.uid)
                  .orderBy('datePublished', descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: kBlack20,
                      color: kPrimaryColor,
                    ),
                  );
                }
                if (snapshot1.data!.docs.isEmpty) {
                  return Center(
                      child: Container(
                    constraints:
                        BoxConstraints(minHeight: 280.h, maxHeight: 340.h),
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? kGrey30 : kLGrey40,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                      color: isDark ? kGrey30.withOpacity(0.4) : kLGrey30,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.post_add_rounded,
                          size: 100,
                          color: kPrimaryColor,
                          shadows: [
                            Shadow(
                              offset: const Offset(2, 5),
                              color: isDark ? kBlack10 : kGrey40,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                          width: double.infinity,
                        ),
                        FittedBox(
                          child: Text(
                            "Posts you have made \nappear here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? kGrey150 : kGrey50,
                              fontSize: 24.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        FittedBox(
                          child: Text(
                            "You haven't made any posts yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? kGrey150 : kGrey50,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
                }
                return ListView.builder(
                  itemCount: snapshot1.data!.docs.length,
                  itemBuilder: (context, index) {
                    dynamic snap = snapshot1.data!.docs[index].data();
                    return PostCard(
                      isAuthority: true,
                      key: ValueKey(snap['postId']),
                      snap: snap,
                    );
                  },
                );
              },
            ),
          ),
          LimitedBox(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('bookmarks', arrayContains: user.uid)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshot2) {
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: kBlack20,
                      color: kPrimaryColor,
                    ),
                  );
                }
                if (snapshot2.data!.docs.isEmpty) {
                  return Center(
                      child: Container(
                    constraints:
                        BoxConstraints(minHeight: 280.h, maxHeight: 340.h),
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark ? kGrey30 : kLGrey40,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                      color: isDark ? kGrey30.withOpacity(0.4) : kLGrey30,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bookmark_added_outlined,
                            size: 100,
                            color: kPrimaryColor,
                            shadows: [
                              Shadow(
                                offset: const Offset(2, 5),
                                color: isDark ? kBlack10 : kGrey40,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                            width: double.infinity,
                          ),
                          FittedBox(
                            child: Text(
                              "Your Bookmarked posts \nappear here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? kGrey150 : kGrey50,
                                fontSize: 24.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          FittedBox(
                            child: Text(
                              "You haven't bookmarked any posts",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? kGrey150 : kGrey50,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                }
                return ListView.builder(
                  itemCount: snapshot2.data!.docs.length,
                  itemBuilder: (context, index) {
                    dynamic snap = snapshot2.data!.docs[index].data();
                    return PostCard(
                      isAuthority: true,
                      key: ValueKey(snap['postId']),
                      snap: snap,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
