class ServiceTimerState {
  final DateTime? startTime;
  final Duration pausedDuration;
  final bool isRunning;

  const ServiceTimerState({
    this.startTime,
    this.pausedDuration = Duration.zero,
    this.isRunning = false,
  });

  Duration get elapsed {
    if (startTime == null) return pausedDuration;
    return DateTime.now().difference(startTime!) + pausedDuration;
  }

  ServiceTimerState copyWith({
    DateTime? startTime,
    Duration? pausedDuration,
    bool? isRunning,
  }) {
    return ServiceTimerState(
      startTime: startTime ?? this.startTime,
      pausedDuration: pausedDuration ?? this.pausedDuration,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
