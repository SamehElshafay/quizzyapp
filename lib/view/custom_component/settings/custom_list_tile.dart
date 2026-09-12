import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.imageWidget,
    required this.onTap,
    required this.text,
    this.size,
  });
  final String text;
  final double? size;

  final Widget? imageWidget;
  final void Function()? onTap;
/*

*/
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: imageWidget ??
          Icon(
            Icons.keyboard_arrow_left,
            size: size ?? 28.r,
          ),
      onTap: onTap,
      title: CustomText(
        text: text,
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
        fontFamily: "Cairo",
        alignment: AlignmentDirectional.topEnd,
      ),
    );
  }
}
