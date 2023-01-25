import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'feed/postcard.dart';
import '../../constants.dart';
import '../../models/user.dart' as model;

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage>
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
    model.User user = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size; // Available screen size

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            padding: EdgeInsets.only(
              top: 10.0,
              left: size.width * 0.22,
              right: size.width * 0.22,
              bottom: 14.0,
            ),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: kGrey40)),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: kGrey40),
                // boxShadow: const [
                //   BoxShadow(
                //     offset: Offset(0, 2),
                //     color: kBlack10,
                //   )
                // ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  color: kGrey30,
                  child: TabBar(
                    dividerColor: kBlack20,
                    indicatorWeight: 0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: kBlack10,
                    unselectedLabelColor: kTextColor.withOpacity(0.8),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                    splashBorderRadius: BorderRadius.circular(50),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: kPrimaryColor.withOpacity(0.9),
                      border: Border.all(
                        color: kPrimaryColor,
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
                    height: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kGrey30,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: kGrey30.withOpacity(0.4),
                      // boxShadow: const [
                      //   BoxShadow(
                      //       offset: Offset(1, 2),
                      //       color: kBlack10,
                      //       blurRadius: 5),
                      // ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.post_add_rounded,
                          size: 100,
                          color: kPrimaryColor,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 5),
                              color: kBlack10,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                        ),
                        FittedBox(
                          child: Text(
                            "Posts you have made \nappear here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kGrey150,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FittedBox(
                          child: Text(
                            "You haven't made any posts yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kGrey150,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
                }
                return ListView.builder(
                  itemCount: snapshot1.data!.docs.length,
                  itemBuilder: (context, index) => PostCard(
                    snap: snapshot1.data!.docs[index].data(),
                  ),
                );
              },
            ),
          ),
          LimitedBox(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .where('postId',
                      whereIn: user.bookmarks.isNotEmpty
                          ? user.bookmarks
                          : ["hello"])
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
                    height: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kGrey30,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: kGrey30.withOpacity(0.4),
                      // boxShadow: const [
                      //   BoxShadow(
                      //       offset: Offset(1, 2),
                      //       color: kBlack10,
                      //       blurRadius: 5),
                      // ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.bookmark_added_outlined,
                            size: 100,
                            color: kPrimaryColor,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 5),
                                color: kBlack10,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                          ),
                          FittedBox(
                            child: Text(
                              "Your Bookmarked posts \nappear here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kGrey150,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FittedBox(
                            child: Text(
                              "You haven't bookmarked any posts",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kGrey150,
                                fontSize: 12,
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
                  itemBuilder: (context, index) => PostCard(
                    snap: snapshot2.data!.docs[index].data(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
