import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hitch_handler/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshThemedHeader extends StatelessWidget {
  const RefreshThemedHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      textStyle: AdaptiveTheme.of(context).theme.textTheme.bodyMedium!,
      failedIcon: Icon(Icons.error,
          color: AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.color),
      completeIcon: Icon(Icons.done,
          color: AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.color),
      idleIcon: Icon(Icons.arrow_downward,
          color: AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.color),
      releaseIcon: Icon(Icons.refresh,
          color: AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.color),
    );
  }
}

class LoadThemedFooter extends StatelessWidget {
  const LoadThemedFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      textStyle: AdaptiveTheme.of(context).theme.textTheme.bodyMedium!,
      failedIcon: Icon(Icons.error,
          color: AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.color),
      idleIcon: Icon(Icons.arrow_downward,
          color: AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.color),
      loadingIcon:
          const SizedBox(height: 20, width: 20, child: CProgressIndicator()),
    );
  }
}

class SpinningIconButton extends AnimatedWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final AnimationController controller;
  const SpinningIconButton(
      {super.key,
      required this.controller,
      required this.icon,
      required this.onPressed})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linearToEaseOut,
    );

    return RotationTransition(
      turns: animation,
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}

class CProgressIndicator extends StatelessWidget {
  const CProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return CircularProgressIndicator(
      strokeWidth: 4,
      backgroundColor: Colors.transparent,
      color: isDark ? kPrimaryColor : kLPrimaryColor,
    );
  }
}

class LProgressIndicator extends StatelessWidget {
  const LProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return LinearProgressIndicator(
      backgroundColor: Colors.transparent,
      color: isDark ? kPrimaryColor : kLPrimaryColor,
    );
  }
}
