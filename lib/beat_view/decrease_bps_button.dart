part of 'beat_view.dart';

class DecreaseBPSButton extends StatefulWidget {
  const DecreaseBPSButton({super.key});

  @override
  State<DecreaseBPSButton> createState() => _DecreaseBPSButtonState();
}

class _DecreaseBPSButtonState extends State<DecreaseBPSButton> implements BPMObserver {
  late final IBeatController _controller;
  late final IBeatModel _beatModel;
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _controller = context.read();
    _beatModel = context.read();
    _beatModel.registerBPMObserver(this);
    _enabled = _beatModel.bps > 1;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: IconButton(
        icon: LayoutBuilder(
          builder: (context, constraints) {
            return Icon(Icons.remove_rounded, size: constraints.maxHeight / 2);
          },
        ),
        onPressed: _enabled ? _controller.decreaseBPS : null,
      ),
    );
  }

  @override
  void updateBPM() {
    if (_beatModel.bps > 1 && !_enabled) {
      setState(() => _enabled = true);
    } else if (_beatModel.bps < 2) {
      setState(() => _enabled = false);
    }
  }
}
