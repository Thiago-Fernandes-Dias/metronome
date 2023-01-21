part of 'beat_view.dart';

class IncreaseBPSButton extends StatefulWidget {
  const IncreaseBPSButton({super.key});

  @override
  State<IncreaseBPSButton> createState() => _IncreaseBPSButtonState();
}

class _IncreaseBPSButtonState extends State<IncreaseBPSButton> implements BPMObserver {
  late final IBeatModel _beatModel;
  late final IBeatController _controller;
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _controller = context.read();
    _beatModel = context.read();
    _beatModel.registerBPMObserver(this);
    _enabled = _beatModel.bps < 100;
  }

  @override
  void dispose() {
    super.dispose();
    _beatModel.removeBPMObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: IconButton(
        icon: LayoutBuilder(
          builder: (context, constraints) {
            return Icon(Icons.add_rounded, size: constraints.maxHeight / 2);
          },
        ),
        onPressed: _enabled ? _controller.increaseBPS : null,
      ),
    );
  }

  @override
  void updateBPM() {
    setState(() => _enabled = _beatModel.bps < 100);
  }
}
