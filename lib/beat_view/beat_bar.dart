part of 'beat_view.dart';

class BeatBar extends StatelessWidget {
  const BeatBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final barHalfWidth = constraints.maxWidth / 2;
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const SizedBox.expand(),
            ),
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: BeatBarHalf(maxWidth: barHalfWidth),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: BeatBarHalf(maxWidth: barHalfWidth),
                  ),
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}

class BeatBarHalf extends StatefulWidget {
  const BeatBarHalf({ super.key, required this.maxWidth});

  final double maxWidth;

  @override
  State<BeatBarHalf> createState() => _BeatBarHalfState();
}

class _BeatBarHalfState extends State<BeatBarHalf> implements BeatObserver, BPMObserver {
  late final IBeatModel _beatModel;
  late Duration _animationDuration;
  double _width = 0;

  @override
  void initState() {
    super.initState();
    _beatModel = context.read();
    _beatModel.registerBeatObserver(this);
    _beatModel.registerBPMObserver(this);
    _animationDuration = Duration(milliseconds: 1000 ~/ _beatModel.bps);
  }

  @override
  void dispose() {
    super.dispose();
    _beatModel.removeBeatObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _animationDuration,
      curve: Curves.ease,
      width: _width,
      color: Colors.blue,
      child: const SizedBox.expand(),
    );
  }
  
  @override
  void updateBeat() {
    setState(() => _width = _width == widget.maxWidth ? 0 : widget.maxWidth); 
  }
  
  @override
  void updateBPM() {
    setState(() => _animationDuration = Duration(milliseconds: 1000 ~/ _beatModel.bps));
  }
}