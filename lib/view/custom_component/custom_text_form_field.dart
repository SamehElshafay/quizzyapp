import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_images.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final IconData? icon;
  final String? hintText;
  final String? labelText;
  bool obscureText;
  final bool? eyes;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Color? iconColor;
  final Color colorFocus;
  final Color? colorInitally;
  final bool readOnly;
  final void Function()? onTap;
  final double? height;
  final TextDirection? textDirection;
  final TextAlignVertical? textAlignVertical;
  final void Function()? onPressedIconSuffic;
  final int? maxLines;
  final int? hintMaxLines;
  final TextDirection? hintTextDirection;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  CustomTextFormField(
      {super.key,
      required this.icon,
      this.eyes,
      this.keyboardType,
      this.hintTextDirection,
      this.onTap,
      this.maxLines = 1,
      this.hintMaxLines,
      this.onPressedIconSuffic,
      this.colorFocus = const Color(0xff077C58),
      this.colorInitally = Colors.grey,
      this.initialValue,
      this.validator,
      this.height,
      this.textAlignVertical,
      this.textDirection,
      this.obscureText = false,
      this.onSaved,
      this.readOnly = false,
      this.iconColor,
      this.hintText,
      this.controller,
      this.inputFormatters,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            height: height,
            child: TextFormField(
              textDirection: textDirection,
              controller: controller,
              obscureText: obscureText,
              onSaved: onSaved,
              onTap: onTap,
              initialValue: initialValue,
              validator: validator,
              textAlignVertical: textAlignVertical,
              readOnly: readOnly,
              maxLines: maxLines,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                  // helperText: "         ",
                  // errorStyle: const TextStyle(
                  //   fontSize: 0.01,
                  // ),
                  hintText: hintText,
                  hintMaxLines: hintMaxLines,
                  hintTextDirection: hintTextDirection,
                  floatingLabelBehavior: FloatingLabelBehavior
                      .always, // to show the label in above always
                  hintStyle: TextStyle(
                      fontSize: 12.sp, color: const Color(0xff727272)),
                  suffixIcon: eyes == null
                      ? icon == null
                          ? null
                          : IconButton(
                              onPressed: onPressedIconSuffic,
                              icon: Icon(
                                icon,
                                color: iconColor == null
                                    ? Color(0xff616161)
                                    : iconColor,
                              ),
                            )
                      : getImage(
                          show: obscureText,
                          onTap: () {
                            setState(() => obscureText = !obscureText);
                          }),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12).r,
                      borderSide: BorderSide(
                        color: colorFocus,
                        width: 2.r,
                      )),
                  errorBorder: OutlineInputBorder(
                      // wehen erro occure
                      borderRadius: BorderRadius.circular(12).r,
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 1.r,
                      )),
                  focusedErrorBorder: OutlineInputBorder(
                      // wehen erro occure
                      borderRadius: BorderRadius.circular(12).r,
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 1.r,
                      )),
                  border: OutlineInputBorder(
                      // when focus in erro
                      borderRadius: BorderRadius.circular(12).r,
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                        width: 1.r,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12).r,
                      borderSide: BorderSide(
                        color: colorInitally!,
                        // color: Color(0xff077C58),
                        width: 1.r,
                      )),
                  labelText: labelText,
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        );
      },
    );
  }

  Widget getImage({required bool show, required void Function()? onTap}) =>
      InkWell(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: Icon(
          !show ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: colorFocus,
        ),
        onTap: onTap,
      );
}
