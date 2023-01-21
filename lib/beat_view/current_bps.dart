part of 'beat_view.dart';

class CurrentBps extends StatefulWidget {
  const CurrentBps({super.key});

  @override
  State<CurrentBps> createState() => _CurrentBpsState();
}

class _CurrentBpsState extends State<CurrentBps> implements BPMObserver {
  late final IBeatModel _beatModel;
  late int _currentBPS;

  @override
  void initState() {
    super.initState();
    _beatModel = context.read();
    _beatModel.registerBPMObserver(this);
    _currentBPS = _beatModel.bps;
  }

  @override
  void dispose() {
    super.dispose();
    _beatModel.removeBPMObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: FittedBox(
            child: Text(
              '$_currentBPS',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: FittedBox(
            child: Text('BPS', style: TextStyle(fontSize: 12)
            ),
          ),
        ),
      ],
    );
  }

  @override
  void updateBPM() {
    setState(() => _currentBPS = _beatModel.bps);
  }
}
