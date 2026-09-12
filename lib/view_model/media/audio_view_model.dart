import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:quizzy_app/model/postion_audio_data.dart';
import 'package:rxdart/rxdart.dart';

class AudioViewModel extends ChangeNotifier {
  String? url;
  final audioPlayer = AudioPlayer();
  // AudioPlayer get audioPlayer => _audioPlayer;
  AudioViewModel({required this.url}) {
    print("-" * 50);
    print("Audio View Model is intlize Constractor ");
    print("-" * 50);
  }

  Future<void> initObject(String url) async {
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          }));
    } on PlayerException catch (e) {
      print("-" * 50);
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // Linux/Windows: maps to PlayerErrorCode.index
      print("Error code: ${e.code}");
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web/Linux: a generic message
      // Windows: MediaPlayerError.message
      print("Error message: ${e.message}");
      print("-" * 50);
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
      print("-" * 50);
      print("Connection aborted: ${e.message}");
      print("-" * 50);
    } catch (e, s) {
      print("-" * 50);
      print(s.toString());
      print("Error loading audio source: $e");
      print("-" * 50);
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionAudioData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionAudioData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionAudioData(
              position: position,
              duration: duration ?? Duration.zero,
              bufferedPosition: bufferedPosition));

  @override
  void dispose() async {
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    await audioPlayer.dispose();
    super.dispose();
    print("-" * 50);
    print("Audio View Model is Deleted From Memory");
    print("-" * 50);
  }
}
