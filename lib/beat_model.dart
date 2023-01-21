import 'dart:async';

abstract class BeatObserver {
  void updateBeat();
}

abstract class BPMObserver {
  void updateBPM();
}

abstract class BeatStateObserver {
  void updateState();
}

enum BeatState { none, on, off }

abstract class IBeatModel {
  void on();

  void off();

  set bps(int value);

  int get bps;

  BeatState get state;

  void registerBeatObserver(BeatObserver observer);

  void registerBPMObserver(BPMObserver observer);

  void removeBPMObserver(BPMObserver observer);

  void removeBeatObserver(BeatObserver observer);

  void registerStateObserver(BeatStateObserver observer);

  void removeStateObserver(BeatStateObserver observer);
}

class BeatModel implements IBeatModel {
  int _bps = 1;
  BeatState _state = BeatState.none;
  final _beatObservers = <BeatObserver>[];
  final _bpmObservers = <BPMObserver>[];
  final _beatStateObservers = <BeatStateObserver>[];
  Timer? _timer;

  @override
  int get bps => _bps;

  @override
  set bps(int newBPS) {
    if (newBPS <= 0) return;
    _bps = newBPS;
    for (final observer in _bpmObservers) {
      observer.updateBPM();
    }
    _setTimer();
  }

  @override
  void off() {
    _state = BeatState.off;
    for (final observer in _beatStateObservers) {
      observer.updateState();
    }
    _timer?.cancel();
  }

  @override
  void on() {
    _state = BeatState.on;
    for (final observer in _beatStateObservers) {
      observer.updateState();
    }
    _setTimer();
  }

  @override
  void registerBPMObserver(BPMObserver observer) {
    _bpmObservers.add(observer);
  }

  @override
  void registerBeatObserver(BeatObserver observer) {
    _beatObservers.add(observer);
  }

  @override
  void removeBPMObserver(BPMObserver observer) {
    _bpmObservers.remove(observer);
  }

  @override
  void removeBeatObserver(BeatObserver observer) {
    _beatObservers.remove(observer);
  }

  @override
  void registerStateObserver(BeatStateObserver observer) {
    _beatStateObservers.add(observer);
  }

  @override
  BeatState get state => _state;

  @override
  void removeStateObserver(BeatStateObserver observer) {
    _beatStateObservers.remove(observer);
  }

  void _setTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(milliseconds: 1000 ~/ bps), (timer) {
      for (final observer in _beatObservers) {
        observer.updateBeat();
      }
    });
  }
}
