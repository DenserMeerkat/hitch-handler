import 'package:flutter/material.dart';
import '../../constants.dart';
import 'buttonscontainer.dart';

class LaunchScreenBody extends StatelessWidget {
  LaunchScreenBody({super.key, required this.maxHeight});
  double maxHeight;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return ListView(
      children: [
        SizedBox(
          height: maxHeight * 0.015, //0.005
        ),
        LogoContainer(size: size),
        SizedBox(
          height: maxHeight * 0.14,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: 10, horizontal: size.width * 0.03),
          child: ButtonsContainer(size: size),
        ),
        SizedBox(
          height: maxHeight * 0.005,
        ),
      ],
    );
  }
}

class LogoContainer extends StatelessWidget {
  const LogoContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      height: size.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Placeholder(
          color: kTextColor.withOpacity(0.1),
        ),
      ),
    );
  }
}
