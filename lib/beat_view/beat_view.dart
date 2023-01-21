import 'package:flutter/material.dart';
import 'package:metronome/beat_controller.dart';
import 'package:provider/provider.dart';

import '../beat_model.dart';

part 'current_bps.dart';
part 'beat_bar.dart';
part 'decrease_bps_button.dart';
part 'increase_bpm_buttom.dart';
part 'start_button.dart';
part 'stop_button.dart';

class BeatView extends StatelessWidget {
  const BeatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Metronome',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: DecreaseBPSButton(),
                  ),
                  Spacer(),
                  Expanded(flex: 4, child: CurrentBps()),
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: IncreaseBPSButton(),
                  ),
                  Spacer(),
                ],
              ),
            ),
            const AspectRatio(aspectRatio: 10),
            const AspectRatio(
              aspectRatio: 15,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: BeatBar(),
              ),
            ),
            const AspectRatio(aspectRatio: 10),
            AspectRatio(
              aspectRatio: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [StartButton(), StopButton()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
