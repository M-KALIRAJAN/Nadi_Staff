import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/service_timer_model.dart';

class ServiceTimerNotifier extends Notifier<ServiceTimerState> {
  Timer? _ticker;

  @override
  ServiceTimerState build() {
    ref.onDispose(() {
      _ticker?.cancel();
    });
    return const ServiceTimerState();
  }

  void start() {
    if (state.isRunning) return;

    final startTime = state.startTime ?? DateTime.now();

    state = state.copyWith(
      startTime: startTime,
      isRunning: true,
    );

    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      // 🔥 force rebuild every second
      state = state.copyWith();
    });
  }

  void pause() {
    if (!state.isRunning) return;

    _ticker?.cancel();

    state = ServiceTimerState(
      startTime: null,
      pausedDuration: state.elapsed,
      isRunning: false,
    );
  }

  void reset() {
    _ticker?.cancel();
    state = const ServiceTimerState();
  }
}

/// ✅ PROVIDER
final serviceTimerProvider =
    NotifierProvider<ServiceTimerNotifier, ServiceTimerState>(
  ServiceTimerNotifier.new,
);
