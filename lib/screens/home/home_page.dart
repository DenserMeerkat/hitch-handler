import 'package:flutter/material.dart';
import 'addform.dart';
import '../../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Container(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: kBackgroundColor,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('*Feed Page*'),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 200,
                width: size.width * 0.9,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(40, 40, 40, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10.0,
                      decoration: const BoxDecoration(
                        color: kErrorColor,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 200,
                width: size.width * 0.9,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(40, 40, 40, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10.0,
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 200,
                width: size.width * 0.9,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(40, 40, 40, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10.0,
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 200,
                width: size.width * 0.9,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(40, 40, 40, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10.0,
                      decoration: const BoxDecoration(
                        color: kErrorColor,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
