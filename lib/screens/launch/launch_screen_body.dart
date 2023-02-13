import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
          height: (maxHeight - 100) * 0.005, //0.005
        ),
        LogoContainer(size: size),
        SizedBox(
          height: (maxHeight - 100) * 0.12,
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
  LogoContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      height: size.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Placeholder(
          color: isDarkMode
              ? kTextColor.withOpacity(0.1)
              : kLTextColor.withOpacity(0.1),
        ),
      ),
    );
  }
}
