import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quizzy_app/model/Image_dimensions_model.dart';
import 'package:quizzy_app/utils/constant.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/view/custom_component/source_type/audio/custom_source_audio.dart';
import 'package:quizzy_app/view/custom_component/source_type/custom_message_source.dart';
import 'package:quizzy_app/view/custom_component/source_type/custom_source_image.dart';
import 'package:quizzy_app/view/custom_component/source_type/custom_source_video.dart';
import 'package:quizzy_app/view_model/media/audio_view_model.dart';
import 'package:quizzy_app/view_model/media/video_view_model.dart';

class CustomQuestionSourceType extends StatelessWidget {
  final QuestionSourceType questionSourceType;
  final String? imageSourceLink;
  final String? fileSourceLink;
  final ImageDimensionsModel? imageDimensionsModel;
  const CustomQuestionSourceType(
      {super.key,
      required this.questionSourceType,
      this.imageDimensionsModel,
      this.fileSourceLink,
      this.imageSourceLink = ""});

  @override
  Widget build(BuildContext context) {
    if (questionSourceType == QuestionSourceType.none) {
      return 50.verticalSpace;
    } else if (questionSourceType == QuestionSourceType.image) {
      debugPrint("*" * 50);
      debugPrint("Image Source : $imageSourceLink");
      debugPrint("*" * 50);
      return (imageSourceLink != null && imageSourceLink!.isNotEmpty)
          ? CustomSourceImage(
              imageSourceLink: imageSourceLink,
              imageDimensionsModel: imageDimensionsModel,
            )
          : const CustomMessageSource(
              message: "غير قادر علي تحميل الصورة",
            );
    } else if (questionSourceType == QuestionSourceType.video) {
      return fileSourceLink != null
          ? ChangeNotifierProvider<VideoViewModel>(
              create: (context) => VideoViewModel(url: fileSourceLink!),
              builder: (context, child) {
                // when Each Enter init The Audio Player
                ExamConstatnt.setNewVideoContext(context);
                context.read<VideoViewModel>().initObject(fileSourceLink!);
                return Column(
                  children: [
                    10.verticalSpace,
                    const CustomSourceVideo(),
                  ],
                );
              },
            )
          : const CustomMessageSource(
              message: "غير قادر علي تحميل الفديو",
            );
    } else {
      return fileSourceLink != null
          ? ChangeNotifierProvider<AudioViewModel>(
              create: (context) => AudioViewModel(url: fileSourceLink),
              builder: (context, child) {
                // when Each Enter init The Audio Player
                context.read<AudioViewModel>().initObject(fileSourceLink!);
                return Column(
                  children: [
                    10.verticalSpace,
                    const CustomSourceAudio(),
                  ],
                );
              },
            )
          : const CustomMessageSource(
              message: "غير قادر علي تحميل الملف الصوتي",
            );
    }
  }
}
