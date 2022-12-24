import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/popupmenu.dart';
import 'buttonscontainer.dart';

class LaunchScreenBody extends StatelessWidget {
  const LaunchScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Column(
      children: [
        Container(
          height: size.height * 0.75,
          width: size.width * 1,
          child: Column(
            children: [
              LogoContainer(size: size),
              ButtonsContainer(size: size),
            ],
          ),
        ),
        BottomText(size: size),
      ],
    );
  }
}

class BottomText extends StatelessWidget {
  const BottomText({
    Key? key,
    required this.size,
  }) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.052,
      child: Center(
        child: Text(
          "CTF PROJECTS",
          style: TextStyle(
            letterSpacing: 2.2,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: kTextColor.withOpacity(0.4),
          ),
        ),
      ),
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
      height: size.height * 0.305,
      decoration: const BoxDecoration(
        color: kBackgroundColor,
      ),
    );
  }
}
