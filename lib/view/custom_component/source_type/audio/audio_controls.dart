import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:quizzy_app/view/custom_component/custom_circular_progress_indicator.dart';
import 'package:quizzy_app/view_model/media/audio_view_model.dart';

class AudioControls extends StatelessWidget {
  const AudioControls({super.key});

  @override
  Widget build(BuildContext context) {
    AudioViewModel controller = context.read<AudioViewModel>();
    return StreamBuilder<PlayerState>(
        stream: controller.audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return Container(
              margin: REdgeInsets.all(8.0),
              width: 50.w,
              height: 50.w,
              child: const CustomCircularProgressIndicator(),
            );
          } else if (playing != true) {
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 40.r,
              onPressed: () => controller.audioPlayer.play(),
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              icon: const Icon(Icons.pause),
              iconSize: 40.r,
              onPressed: () => controller.audioPlayer.pause(),
            );
          } else {
            return IconButton(
              icon: const Icon(Icons.replay),
              iconSize: 40.r,
              onPressed: () => controller.audioPlayer.seek(Duration.zero),
            );
          }
        });
  }
}
