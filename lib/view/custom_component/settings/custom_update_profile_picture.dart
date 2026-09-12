import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizzy_app/utils/app_images.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view_model/utils/theme/theme_view_model.dart';

class CustomUpdateProfilePicture extends StatelessWidget {
  final String? imageUrl;
  final void Function()? onTap;
  final String? filePath;
  const CustomUpdateProfilePicture(
      {super.key, this.filePath, this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            width: 170.w,
            height: 170.w,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(31, 67, 109, 0.25),
                      blurRadius: 6,
                      offset: Offset(0, 4))
                ]),
            child: filePath != null
                ? Image.file(
                    File(filePath!),
                    fit: BoxFit.cover,
                  )
                : imageUrl == null
                    ? Image.asset(
                        Assets.placeholderProfile,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: imageUrl!,
                        fadeInDuration: const Duration(seconds: 1),
                        placeholder: (context, url) =>
                            const CustomCircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
          ),
          RPadding(
            padding: REdgeInsets.only(bottom: 10),
            child: Image.asset(
              Assets.camera,
              cacheHeight: 32,
              cacheWidth: 32,
              color:
                  Get.find<ThemeViewMode>().isDarkMode() ? Colors.white : null,
            ),
          )
        ],
      ),
    );
  }
}
