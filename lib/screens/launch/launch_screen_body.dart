import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants.dart';
import 'buttonscontainer.dart';

class LaunchScreenBody extends StatelessWidget {
  const LaunchScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return ListView(
      children: [
        SizedBox(
          height: 20.h,
        ),
        LogoContainer(size: size),
        SizedBox(
          height: 60.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
          child: ButtonsContainer(size: size),
        ),
        SizedBox(
          height: 10.h,
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
    bool isDarkMode = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 200.h,
      child: Padding(
        padding: EdgeInsets.all(20.0.h),
        child: Placeholder(
          color: isDarkMode
              ? kTextColor.withOpacity(0.1)
              : kLTextColor.withOpacity(0.1),
        ),
      ),
    );
  }
}
