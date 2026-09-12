class PositionAudioData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
  PositionAudioData(
      {required this.bufferedPosition,
      required this.duration,
      required this.position});
}
