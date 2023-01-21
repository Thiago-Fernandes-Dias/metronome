import 'package:flutter/material.dart';
import 'package:metronome/beat_controller.dart';
import 'package:metronome/beat_model.dart';
import 'package:provider/provider.dart';

import 'beat_view/beat_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final model = BeatModel();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          Provider<IBeatModel>.value(value: model),
          Provider<IBeatController>(create: (context) => BeatController(model: model)),
        ],
        child: const BeatView(),
      ),
    );
  }
}
