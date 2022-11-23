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
          height: size.height * 0.95,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(30, 30, 30, 1),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
              top: Radius.circular(0.0),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 5,
                color: Color.fromRGBO(10, 10, 10, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                height: size.height * 0.10,
                color: kBackgroundColor,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {}, //Todo
                        child: Icon(
                          Icons.info_outline,
                          color: kTextColor.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      //PopupMenu(),
                      const SizedBox(
                        width: kDefaultPadding,
                      )
                    ],
                  ),
                ),
              ),
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
      height: size.height * 0.04,
      child: Center(
        child: Text(
          "CTF PROJECTS",
          style: TextStyle(
            letterSpacing: 2.0,
            fontSize: 10,
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
      height: size.height * 0.45,
      decoration: const BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40.0),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: kPrimaryColor,
          )
        ],
      ),
    );
  }
}
