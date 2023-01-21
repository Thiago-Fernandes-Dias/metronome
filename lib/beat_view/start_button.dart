part of 'beat_view.dart';

class StartButton extends StatefulWidget {
  const StartButton({super.key});

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> implements BeatStateObserver {
  late final IBeatController _controller;
  late final IBeatModel _model;
  late bool _active;

  @override
  void initState() {
    super.initState();
    _controller = context.read();
    _model = context.read()..registerStateObserver(this);
    _active = _model.state != BeatState.on;
  }

  @override
  void dispose() {
    super.dispose();
    _model.removeStateObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: _active ? 1 : .4,
        child: AspectRatio(
          aspectRatio: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
            ),
            onPressed: () {
              if (_active) {
                _controller.start();
              }
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Icon(Icons.play_arrow_rounded, size: constraints.maxHeight);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void updateState() {
    setState(() => _active = _model.state != BeatState.on);
  }
}
