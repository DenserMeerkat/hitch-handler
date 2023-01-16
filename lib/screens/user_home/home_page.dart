import 'package:flutter/material.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          automaticallyImplyLeading: false,
          backgroundColor: kBackgroundColor,
          expandedHeight: 70,
          flexibleSpace: FlexibleSpaceBar(
            background: SafeArea(
              child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.12,
                    right: size.width * 0.12,
                    top: 15,
                    bottom: 15,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: kGrey40,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 2),
                              color: kBlack15,
                            ),
                          ]),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            "Search",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: kTextColor.withOpacity(0.5),
                              letterSpacing: 1,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.search_rounded,
                            color: kTextColor.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  )
                  // TextField(
                  //   readOnly: true,
                  //   onTap: () {},
                  //   cursorColor: Colors.grey,
                  //   decoration: InputDecoration(
                  //     hintText: "Search...",
                  //     hintStyle: TextStyle(),
                  //     prefixIcon: Icon(
                  //       Icons.search,
                  //       color: kTextColor.withOpacity(0.5),
                  //     ),
                  //     filled: true,
                  //     fillColor: kGrey30,
                  //     border: outlineInputBorder,
                  //     focusedBorder: outlineInputBorder,
                  //     enabledBorder: outlineInputBorder,
                  //   ),
                  // ),
                  ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              generatePost(size, kErrorColor),
              generatePost(size, kPrimaryColor),
              generatePost(size, kPrimaryColor),
              generatePost(size, kErrorColor),
              generatePost(size, kSecButtonColor),
              generatePost(size, kStudentColor),
              generatePost(size, kSecButtonColor),
              generatePost(size, kPrimaryColor),
            ],
          ),
        ),
      ],
    );
  }

  Container generatePost(Size size, Color? accent) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      height: 200,
      width: size.width * 0.9,
      decoration: const BoxDecoration(
        color: kGrey40,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10.0,
            decoration: BoxDecoration(
              color: accent,
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(10.0)),
            ),
          ),
        ],
      ),
    );
  }
}
