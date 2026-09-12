import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy_app/view_model/media/video_view_model.dart';

class CustomSourceVideo extends StatelessWidget {
  const CustomSourceVideo({super.key, this.fileSourceLink});
  final String? fileSourceLink;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: Consumer<VideoViewModel>(
              builder: (context, value, child) {
                return Chewie(
                  controller: value.chewieController,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
