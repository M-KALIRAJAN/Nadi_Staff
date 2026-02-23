class TimerState {
  final int totalSeconds;
  final bool isRunning;

  const TimerState({
    required this.totalSeconds,
    required this.isRunning,
  });

  Duration get duration => Duration(seconds: totalSeconds);
}