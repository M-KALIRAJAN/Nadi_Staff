// import 'dart:async';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../model/service_timer_model.dart';

// class ServiceTimerNotifier extends Notifier<ServiceTimerState> {
//   Timer? _ticker;

//   @override
//   ServiceTimerState build() {
//     ref.onDispose(() {
//       _ticker?.cancel();
//     });
//     return const ServiceTimerState();
//   }

//   void start() {
//     if (state.isRunning) return;

//     final startTime = state.startTime ?? DateTime.now();

//     state = state.copyWith(
//       startTime: startTime,
//       isRunning: true,
//     );
//     _ticker?.cancel();
//     _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
//       state = state.copyWith();
//     });
//   }

//   void pause() {
//     if (!state.isRunning) return;

//     _ticker?.cancel();

//     state = ServiceTimerState(
//       startTime: null,
//       pausedDuration: state.elapsed,
//       isRunning: false,
//     );
//   }

//   void reset() {
//     _ticker?.cancel();
//     state = const ServiceTimerState();
//   }
// }

// /// ✅ PROVIDER
// final serviceTimerProvider =
//     NotifierProvider<ServiceTimerNotifier, ServiceTimerState>(
//   ServiceTimerNotifier.new,

// );
// lib/providers/timer_provider.dart

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/timer_state.dart';

class TimerNotifier extends Notifier<TimerState> {
  Timer? _timer;

  @override
  TimerState build() {
    // Cancel timer automatically when provider is disposed
    ref.onDispose(() {
      _timer?.cancel();
    });

    return const TimerState(totalSeconds: 0, isRunning: false);
  }

  /// Initialize timer with API response
  void initialize({
    required int totalSeconds,
    required bool isRunning,
  }) {
    _timer?.cancel();

    state = TimerState(totalSeconds: totalSeconds, isRunning: isRunning);

    if (isRunning) {
      _startLocalTimer();
    }
  }

  void _startLocalTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = TimerState(
        totalSeconds: state.totalSeconds + 1,
        isRunning: true,
      );
    });
  }

  /// Pause timer locally
  void pause() {
    _timer?.cancel();
    state = TimerState(totalSeconds: state.totalSeconds, isRunning: false);
  }

  /// Resume timer locally
  void resume() {
    if (!state.isRunning) {
      state = TimerState(totalSeconds: state.totalSeconds, isRunning: true);
      _startLocalTimer();
    }
  }

  /// Reset timer
  void reset() {
    _timer?.cancel();
    state = const TimerState(totalSeconds: 0, isRunning: false);
  }
}

/// Timer state class
class TimerState {
  final int totalSeconds;
  final bool isRunning;

  const TimerState({
    required this.totalSeconds,
    required this.isRunning,
  });

  Duration get duration => Duration(seconds: totalSeconds);

  /// Formatted time like HH:mm:ss
  String get formattedTime {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}

/// Global provider
final timerProvider = NotifierProvider<TimerNotifier, TimerState>(
  () => TimerNotifier(),
);