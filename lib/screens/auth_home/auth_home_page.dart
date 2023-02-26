import 'package:flutter/material.dart';
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/screens/user_home/feed/postcard.dart';
import 'package:hitch_handler/screens/user_home/search_page.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user.dart' as model;

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy("datePublished", descending: true)
          .where("domain", isEqualTo: user.domain)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: kBlack20,
              color: kPrimaryColor,
            ),
          );
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              snap: true,
              //pinned: true,
              floating: true,
              automaticallyImplyLeading: false,
              backgroundColor: isDark ? kBackgroundColor : kLBlack20,
              surfaceTintColor: isDark ? kBackgroundColor : kLBlack20,
              elevation: 0,
              expandedHeight: 60,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: isDark ? kGrey40 : kLGrey40),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const SearchPage(),
                          transitionDuration: const Duration(milliseconds: 300),
                          reverseTransitionDuration:
                              const Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Hero(
                          tag: "search",
                          child: Material(
                            type: MaterialType.transparency,
                            child: Container(
                              width: 120,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isDark ? kGrey40 : kLGrey40,
                                ),
                                color: isDark
                                    ? kGrey40.withOpacity(0.6)
                                    : kLBlack10,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: isDark ? kTextColor : kLTextColor,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("Search"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  return PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  );
                }),
                childCount: snapshot.data!.docs.length,
              ),
            ),
          ],
        );
      },
    );
  }
}

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
