import 'package:flutter/material.dart';
import '../../../constants.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.bgcolor,
    required this.tooltip,
  });

  final Color fgcolor;
  final String title;
  final Color bgcolor;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: false,
      triggerMode: TooltipTriggerMode.tap,
      message: tooltip,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: bgcolor,
        border: Border.all(color: kTextColor.withAlpha(100), width: 1),
      ),
      padding: const EdgeInsets.all(8.0),
      textStyle: const TextStyle(
        color: kTextColor,
        fontSize: 15,
      ),
      showDuration: const Duration(seconds: 2),
      waitDuration: const Duration(seconds: 1),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        height: 20,
        decoration: const BoxDecoration(
            color: kBlack20,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(5.0), bottom: Radius.circular(0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10.0),
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: kTextColor.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            FittedBox(
              child: Icon(
                Icons.help_outline_outlined,
                color: fgcolor.withOpacity(0.7),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class FieldToolTip extends StatelessWidget {
//   const FieldToolTip({
//     super.key,
//     required this.bgcolor,
//     required this.tooltip,
//   });

//   final Color bgcolor;
//   final String tooltip;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
//       height: 20,
//       decoration: const BoxDecoration(
//           color: kBlack20,
//           borderRadius: BorderRadius.vertical(
//               top: Radius.circular(5.0), bottom: Radius.circular(0))),
//       child: Tooltip(
//         triggerMode: TooltipTriggerMode.tap,
//         message: tooltip,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           color: bgcolor,
//         ),
//         height: 15,
//         padding: const EdgeInsets.all(8.0),
//         preferBelow: false,
//         textStyle: const TextStyle(
//           fontSize: 15,
//         ),
//         showDuration: const Duration(seconds: 2),
//         waitDuration: const Duration(seconds: 1),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             FittedBox(
//               child: Icon(
//                 Icons.help_outline_outlined,
//                 color: kTextColor.withOpacity(0.8),
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 3.0),
//             Text(
//               "help",
//               style: TextStyle(
//                 color: kTextColor.withOpacity(0.8),
//                 fontWeight: FontWeight.normal,
//                 letterSpacing: 1.5,
//                 fontSize: 10,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
