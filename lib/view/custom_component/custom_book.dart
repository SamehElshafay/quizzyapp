import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzy_app/model/book_model.dart';

import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/utils/general_utils.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';

import 'custom_text.dart';

class CustomBook extends StatelessWidget {
  final bool isShowArrow;
  final void Function()? onTap;
  final BookModel bookModel;

  const CustomBook({
    super.key,
    required this.bookModel,
    this.isShowArrow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110.w,
        height: 140.h,
        decoration: BoxDecoration(
            color:
                GeneralUtils.instance.generateColor(), // to genearate a Color
            borderRadius: BorderRadius.circular(17).r,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 5,
                  offset: Offset(0, 4))
            ]),
        child: bookModel.photo == null ||
                bookModel.photo!.isEmpty ||
                bookModel.photo == ExamConstatnt.isDeafultImage
            ? Center(
                child: CustomText(
                  text: bookModel.name!,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w800,
                  fontSize: 12.sp,
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.w, top: 10.h),
                    child: CustomText(
                      text: bookModel.name!,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.w800,
                      fontSize: 12.sp,
                      color: Colors.white,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  2.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Image.asset(
                      Assets.imagesNextArrow,
                      cacheHeight: 24,
                      cacheWidth: 24,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      width: double.infinity,
                      imageUrl: bookModel.photo ?? "",
                      fadeInDuration: const Duration(seconds: 1),
                      placeholder: (context, url) =>
                          const CustomCircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Column(
                        children: [
                          Icon(Icons.error),
                          CustomText(
                            text: 'No Image',
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
/*
 Expanded(
                child: Image.asset(
              imageAssetName,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ))
*/
