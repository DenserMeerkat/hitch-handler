import 'package:flutter/material.dart';
import 'feed/postcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) => PostCard(
            snap: snapshot.data!.docs[index].data(),
          ),
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
