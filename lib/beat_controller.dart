import 'dart:async';

import 'package:flutter/material.dart';
import 'package:metronome/beat_model.dart';
import 'package:metronome/beat_view/beat_view.dart';

abstract class IBeatController {
  FutureOr<void> start();
  void stop();
  void increaseBPS();
  void decreaseBPS();
  void setBPS(int bps);
}

class BeatController implements IBeatController {
  BeatController({required this.model});

  final IBeatModel model;

  @override
  void decreaseBPS() {
    final curBSP = model.bps;
    model.bps = curBSP - 1;
  }

  @override
  void increaseBPS() {
    final curBSP = model.bps;
    model.bps = curBSP + 1;
  }

  @override
  void setBPS(int bps) {
    model.bps = bps;
  }

  @override
  void start() {
    model.on();
  }

  @override
  void stop() {
    model.off();
  }
}
