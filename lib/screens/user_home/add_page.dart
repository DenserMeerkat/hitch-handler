import 'package:flutter/material.dart';
import 'add/addform.dart';
import '../../constants.dart';

class AddPage extends StatelessWidget {
  static String routeName = '/add_page';
  static ScrollController scrollController = ScrollController();
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return CustomScrollView(
      slivers: [
        // const SliverAppBar(
        //   floating: true,
        //   pinned: true,
        //   backgroundColor: kBackgroundColor,
        //   flexibleSpace: FlexibleSpaceBar(
        //     title: Text('*Add Page*'),
        //   ),
        // ),
        SliverFillRemaining(
          child: Container(
            height: size.height * 0.9,
            color: kGrey30.withOpacity(0.7),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  const Text(
                    "Add new Problem",
                    style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    "Explain you problem with details.",
                    style: TextStyle(
                      color: kTextColor.withOpacity(0.7),
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  AddForm(
                    scrollController: scrollController,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
