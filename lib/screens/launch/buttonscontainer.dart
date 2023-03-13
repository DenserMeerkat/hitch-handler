import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../args_class.dart';
import '../../constants.dart';
import '../components/customfields/customelevatedbutton.dart';
import '../login/admin_login.dart';
import '../login/student_login.dart';
import '../login/authority_login.dart';

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Container(
      height: 250.h,
      width: 300.w,
      padding: EdgeInsets.only(
        top: 20.h,
        right: 5.w,
        left: 5.w,
        bottom: 15.h,
      ),
      decoration: BoxDecoration(
        color: isDark ? kGrey30 : kLGrey30,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30.0.r),
          top: Radius.circular(30.0.r),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.w, 2.5.h),
            color: isDark ? kBlack15 : kGrey150,
          ),
          BoxShadow(
            offset: Offset(0.w, -5.h),
            color: isDark ? kPrimaryColor : kLPrimaryColor,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: "StudentHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: isDark ? kBackgroundColor : kLBlack10,
                iconcolor: isDark ? kBlack20 : kBlack20,
                fgcolor: isDark ? kStudentColor : kLStudentColor,
                shcolor: isDark ? kBlack10 : kLGrey70,
                textcolor: isDark ? kStudentColor : kBlack20,
                bradius: 40.0.r,
                fsize: 13,
                title: "Student / Staff",
                icon: Icons.school,
                press: () {
                  LoginSignUpArguments args = LoginSignUpArguments(
                    "StudentHero",
                    isDark ? kStudentColor : kLStudentColor,
                    "Student / Staff",
                    Icons.school,
                  );
                  Navigator.pushNamed(
                    context,
                    StudentLoginScreen.routeName,
                    arguments: args,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Hero(
            tag: "AuthorityHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: isDark ? kBackgroundColor : kLBlack10,
                iconcolor: kBlack20,
                fgcolor: isDark ? kAuthorityColor : kLAuthorityColor,
                shcolor: isDark ? kBlack10 : kLGrey70,
                textcolor: isDark ? kAuthorityColor : kBlack20,
                bradius: 40.0.r,
                fsize: 13,
                title: "Authority",
                icon: Icons.work,
                press: () {
                  LoginSignUpArguments args = LoginSignUpArguments(
                    "AuthorityHero",
                    isDark ? kAuthorityColor : kLAuthorityColor,
                    "Authority",
                    Icons.work,
                  );

                  Navigator.pushNamed(
                    context,
                    AuthorityLoginScreen.routeName,
                    arguments: args,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Hero(
            tag: "AdminHero",
            child: Material(
              type: MaterialType.transparency,
              child: CustomElevatedButtonWithIcon(
                bgcolor: isDark ? kBackgroundColor : kLBlack10,
                iconcolor: kBlack20,
                fgcolor: isDark ? kAdminColor : kLAdminColor,
                shcolor: isDark ? kBlack10 : kLGrey70,
                textcolor: isDark ? kAdminColor : kBlack20,
                bradius: 40.0.r,
                fsize: 13,
                title: "Admin",
                icon: Icons.key,
                press: () {
                  LoginSignUpArguments args = LoginSignUpArguments(
                    "AdminHero",
                    isDark ? kAdminColor : kLAdminColor,
                    "Admin",
                    Icons.key,
                  );

                  Navigator.pushNamed(
                    context,
                    AdminLoginScreen.routeName,
                    arguments: args,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
