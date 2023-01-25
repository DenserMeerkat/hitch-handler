import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: loading
              ? const LinearProgressIndicator(
                  backgroundColor: kBlack20,
                  color: kPrimaryColor,
                )
              : Container(),
        ),
        SliverFillRemaining(
          child: Container(
            height: size.height * 0.9,
            color: kGrey30.withOpacity(0.7),
            child: SingleChildScrollView(
              controller: AddPage.scrollController,
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
                  NotificationListener<IsLoading>(
                    child: AddForm(
                      scrollController: AddPage.scrollController,
                    ),
                    onNotification: (n) {
                      setState(() {
                        loading = n.isLoading;
                      });
                      return true;
                    },
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
