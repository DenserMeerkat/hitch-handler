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
  int? stackIndex = 0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size; // Available screen size

    return Container(
      //color: kGrey30,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('uid', isEqualTo: user.uid)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot1) {
            if (snapshot1.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder(
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
                    child: CircularProgressIndicator(),
                  );
                }
                return CustomScrollView(slivers: [
                  SliverAppBar(
                    snap: true,
                    pinned: true,
                    floating: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        padding: EdgeInsets.only(
                          top: 12.0,
                          left: size.width * 0.22,
                          right: size.width * 0.22,
                          bottom: 15.0,
                        ),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  color: kBlack10,
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                color: kBlack15,
                                child: TabBar(
                                  labelColor: kBlack10,
                                  unselectedLabelColor:
                                      kTextColor.withOpacity(0.8),
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                  unselectedLabelStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                  splashBorderRadius: BorderRadius.circular(50),
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: kPrimaryColor.withOpacity(0.9),
                                      border: Border.all(
                                        color: kPrimaryColor,
                                        width: 2,
                                      )),
                                  controller: _tabController,
                                  tabs: const <Widget>[
                                    Tab(
                                      text: "Posts",
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
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        CustomScrollView(
                          slivers: [
                            snapshot1.hasError
                                ? const Center(child: Text('An error occured'))
                                : snapshot1.hasData &&
                                        snapshot1.data!.docs.isEmpty
                                    ? SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                          return PostCard(
                                            snap: snapshot1.data!.docs[index]
                                                .data(),
                                          );
                                        },
                                            childCount:
                                                snapshot2.data!.docs.length),
                                      )
                                    : Container(
                                        child: Center(child: Text("No Posts")),
                                      ),
                          ],
                        ),
                        CustomScrollView(
                          slivers: [
                            snapshot2.hasError
                                ? const Center(child: Text('An error occured'))
                                : snapshot2.hasData &&
                                        snapshot2.data!.docs.isEmpty
                                    ? SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                          return PostCard(
                                            snap: snapshot1.data!.docs[index]
                                                .data(),
                                          );
                                        },
                                            childCount:
                                                snapshot2.data!.docs.length),
                                      )
                                    : Container(
                                        child: Center(child: Text("No Posts")),
                                      ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]);
              },
            );
          }),
      /////////////////////////////////
    );
  }
}




// return StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('posts')
//                   .where('postId',
//                       whereIn: user.bookmarks.isNotEmpty
//                           ? user.bookmarks
//                           : ["hello"])
//                   .snapshots(),
//               builder: (context,
//                   AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                       snapshot2) {
//                 if (snapshot2.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 return CustomScrollView(slivers: [
//                   SliverAppBar(
//                     snap: true,
//                     pinned: true,
//                     floating: true,
//                     automaticallyImplyLeading: false,
//                     backgroundColor: Colors.transparent,
//                     elevation: 0,
//                     flexibleSpace: FlexibleSpaceBar(
//                       background: Container(
//                         padding: EdgeInsets.only(
//                           top: 12.0,
//                           left: size.width * 0.22,
//                           right: size.width * 0.22,
//                           bottom: 15.0,
//                         ),
//                         child: Center(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   offset: Offset(0, 2),
//                                   color: kBlack10,
//                                 )
//                               ],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: Container(
//                                 color: kBlack15,
//                                 child: TabBar(
//                                   labelColor: kBlack10,
//                                   unselectedLabelColor:
//                                       kTextColor.withOpacity(0.8),
//                                   labelStyle: const TextStyle(
//                                     fontWeight: FontWeight.w800,
//                                     fontSize: 14,
//                                     letterSpacing: 0.5,
//                                   ),
//                                   unselectedLabelStyle: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                     letterSpacing: 0.5,
//                                   ),
//                                   splashBorderRadius: BorderRadius.circular(50),
//                                   indicator: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(50),
//                                       color: kPrimaryColor.withOpacity(0.9),
//                                       border: Border.all(
//                                         color: kPrimaryColor,
//                                         width: 2,
//                                       )),
//                                   controller: _tabController,
//                                   tabs: const <Widget>[
//                                     Tab(
//                                       text: "Posts",
//                                     ),
//                                     Tab(
//                                       text: "Bookmarks",
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SliverFillRemaining(
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: <Widget>[
//                         CustomScrollView(
//                           slivers: [
//                             snapshot1.hasError
//                                 ? const Center(child: Text('An error occured'))
//                                 : snapshot1.hasData &&
//                                         snapshot1.data!.docs.isEmpty
//                                     ? SliverList(
//                                         delegate: SliverChildBuilderDelegate(
//                                             (context, index) {
//                                           return PostCard(
//                                             snap: snapshot1.data!.docs[index]
//                                                 .data(),
//                                           );
//                                         },
//                                             childCount:
//                                                 snapshot2.data!.docs.length),
//                                       )
//                                     : Container(
//                                         child: Center(child: Text("No Posts")),
//                                       ),
//                           ],
//                         ),
//                         CustomScrollView(
//                           slivers: [
//                             snapshot2.hasError
//                                 ? const Center(child: Text('An error occured'))
//                                 : snapshot2.hasData &&
//                                         snapshot2.data!.docs.isEmpty
//                                     ? SliverList(
//                                         delegate: SliverChildBuilderDelegate(
//                                             (context, index) {
//                                           return PostCard(
//                                             snap: snapshot1.data!.docs[index]
//                                                 .data(),
//                                           );
//                                         },
//                                             childCount:
//                                                 snapshot2.data!.docs.length),
//                                       )
//                                     : Container(
//                                         child: Center(child: Text("No Posts")),
//                                       ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]);
//               },
//             );
//           }),























// SliverAppBar(
//           floating: true,
//           snap: true,
//           automaticallyImplyLeading: false,
//           backgroundColor: kBackgroundColor,
//           expandedHeight: 70,
//           flexibleSpace: FlexibleSpaceBar(
//             background: SafeArea(
//               child: Padding(
//                   padding: EdgeInsets.only(
//                     left: size.width * 0.12,
//                     right: size.width * 0.12,
//                     top: 15,
//                     bottom: 15,
//                   ),
//                   child: GestureDetector(
//                     onTap: () {
//                       final snackBar = SnackBar(
//                         content: Text("SnackBar implementation"),
//                         action: SnackBarAction(
//                           label: "Done",
//                           onPressed: () {},
//                         ),
//                       );
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(snackBar)
//                           .closed
//                           .then((value) =>
//                               ScaffoldMessenger.of(context).clearSnackBars());
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       decoration: BoxDecoration(
//                           color: kGrey40,
//                           borderRadius: BorderRadius.circular(50),
//                           boxShadow: const [
//                             BoxShadow(
//                               offset: Offset(0, 2),
//                               color: kBlack15,
//                             ),
//                           ]),
//                       child: Row(
//                         children: [
//                           const SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             "Search",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                               color: kTextColor.withOpacity(0.5),
//                               letterSpacing: 1,
//                             ),
//                           ),
//                           const Spacer(),
//                           Icon(
//                             Icons.search_rounded,
//                             color: kTextColor.withOpacity(0.5),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                   // TextField(
//                   //   readOnly: true,
//                   //   onTap: () {},
//                   //   cursorColor: Colors.grey,
//                   //   decoration: InputDecoration(
//                   //     hintText: "Search...",
//                   //     hintStyle: TextStyle(),
//                   //     prefixIcon: Icon(
//                   //       Icons.search,
//                   //       color: kTextColor.withOpacity(0.5),
//                   //     ),
//                   //     filled: true,
//                   //     fillColor: kGrey30,
//                   //     border: outlineInputBorder,
//                   //     focusedBorder: outlineInputBorder,
//                   //     enabledBorder: outlineInputBorder,
//                   //   ),
//                   // ),
//                   ),
//             ),
//           ),
//         ),
