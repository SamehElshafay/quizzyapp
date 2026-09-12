import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:quizzy_app/utils/constant/exam_costant.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view/custom_component/custom_message.dart';
import 'package:quizzy_app/view/custom_component/custom_text.dart';
import 'package:quizzy_app/view/custom_component/source_type/custom_message_source.dart';
import 'package:quizzy_app/view/screens/exam/exam_type/true_false_exam.dart';

import 'package:video_player/video_player.dart';

class VideoViewModel extends ChangeNotifier {
  String url;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool isFirstTimeIntialize = true;
  VideoViewModel({required this.url}) {
    print("+" * 50);
    print("VideoViewModel Model is intlize Constractor ");
    print("+" * 50);
  }
  ChewieController get chewieController => _chewieController!;
  Future<void> initObject(String url) async {
    print(" / " * 50);
    print("VideoViewModel Model is intlize Constractor ");
    print(" / " * 50);
    _videoPlayerController = null;
    _chewieController = null;
    ExamConstatnt.setPageHasVideo(
        isPageHasVideo:
            true); // Hint to know this Page have a Video and Make this Variabl Global

    try {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
      _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          errorBuilder: ((context, errorMessage) => const CustomMessageSource(
                message: "غير قادر علي تحميل الفديو",
              )),
          placeholder: const CustomCircularProgressIndicator(),
          showControlsOnInitialize: false,
          autoPlay: true,
          autoInitialize: true);

      Future.delayed(const Duration(seconds: 2), () async {
        notifyListeners();
      });

      // if (!isFirstTimeIntialize) {
      //   notifyListeners();
      // } else {
      //   isFirstTimeIntialize = false;
      // }
    } catch (e, s) {
      print(" / " * 50);
      print(s.toString());
      print(" / " * 50);
    }
    // notifyListeners();
  }

  void deleteControllerManually() async {
    ExamConstatnt.setPageHasVideo(
        isPageHasVideo:
            false); // Hint to know this Page have No a Video and Make this Variabl Global
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    //  await _videoPlayerController!.pause();
    _videoPlayerController!.dispose();
    _chewieController!.dispose();
    notifyListeners(); // to update Video Screen if we have two Video show one another one
    print("*" * 50);
    print("VideoViewModel  is Deleted From Memory");
    print("*" * 50);
  }

  @override
  void dispose() async {
    if (ExamConstatnt.isPageHasVideo) {
      // to Solve the Problem if go to another Question before pasue the Video
      deleteControllerManually();
    }
    print("*" * 50);
    print("VideoViewModel  is dispose ");
    print("*" * 50);
    super.dispose(); // لازم تعملها ديما في اخر سطر  عندك
  }
}
