import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MixerScreen extends StatefulWidget {
  const MixerScreen({super.key});

  static const String route = '/mixer';

  @override
  State<MixerScreen> createState() => _MixerScreenState();
}

class _MixerScreenState extends State<MixerScreen> {
  double low = 0.2;
  double mid = 0.5;
  double high = 0.7;
  double reverb = 0.3;
  double delay = 0.4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mixer')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 800;
          final EdgeInsets pagePadding = EdgeInsets.symmetric(
            horizontal: isWide ? 48 : 20,
            vertical: 16,
          );
          return SingleChildScrollView(
            padding: pagePadding,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TransportBar(),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _ChannelStrip(title: 'Vocals', volume: 0.8, pan: -0.2),
                        _ChannelStrip(title: 'Guitar', volume: 0.6, pan: 0.1),
                        _ChannelStrip(title: 'Bass', volume: 0.7, pan: 0.0),
                        _ChannelStrip(title: 'Drums', volume: 0.9, pan: 0.0),
                        _FxRack(
                          low: low,
                          mid: mid,
                          high: high,
                          reverb: reverb,
                          delay: delay,
                          onChanged: (l, m, h, r, d) => setState(() {
                            low = l;
                            mid = m;
                            high = h;
                            reverb = r;
                            delay = d;
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TransportBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _TButton(icon: Icons.play_arrow, label: 'Play'),
            const SizedBox(width: 8),
            _TButton(icon: Icons.stop, label: 'Stop'),
            const SizedBox(width: 8),
            _TButton(icon: Icons.fiber_manual_record, label: 'Rec', highlight: true),
            const Spacer(),
            const Icon(Icons.timer, color: AppTheme.muted),
            const SizedBox(width: 8),
            Text('01:23 / 03:45', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _TButton extends StatelessWidget {
  const _TButton({required this.icon, required this.label, this.highlight = false});
  final IconData icon;
  final String label;
  final bool highlight;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: highlight ? AppTheme.accent : AppTheme.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: highlight ? Colors.black : Colors.white),
          const SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: highlight ? Colors.black : Colors.white)),
        ],
      ),
    );
  }
}

class _ChannelStrip extends StatelessWidget {
  const _ChannelStrip({required this.title, required this.volume, required this.pan});
  final String title;
  final double volume;
  final double pan; // -1..1
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              _VuMeter(level: volume),
              const SizedBox(height: 12),
              _Knob(label: 'Vol', value: volume),
              const SizedBox(height: 8),
              _Knob(label: 'Pan', value: (pan + 1) / 2),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _MiniButton(icon: Icons.mic, label: 'Mute')),
                  const SizedBox(width: 8),
                  Expanded(child: _MiniButton(icon: Icons.headphones, label: 'Solo')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VuMeter extends StatelessWidget {
  const _VuMeter({required this.level});
  final double level; // 0..1
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Container(color: const Color(0xFF0E0F13)),
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: level.clamp(0, 1),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF00E676), Color(0xFFFFD600)]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Knob extends StatelessWidget {
  const _Knob({required this.label, required this.value});
  final String label;
  final double value; // 0..1
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const SweepGradient(
              colors: [AppTheme.secondary, AppTheme.primary],
              startAngle: 0,
              endAngle: 3.14 * 2,
            ),
          ),
          child: Center(
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppTheme.card,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text((value * 100).round().toString(), style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

class _MiniButton extends StatelessWidget {
  const _MiniButton({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: 6),
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _FxRack extends StatelessWidget {
  const _FxRack({
    required this.low,
    required this.mid,
    required this.high,
    required this.reverb,
    required this.delay,
    required this.onChanged,
  });
  final double low;
  final double mid;
  final double high;
  final double reverb;
  final double delay;
  final void Function(double l, double m, double h, double r, double d) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 460,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FX Rack', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              _LabeledSlider(
                label: 'Low',
                value: low,
                color: const Color(0xFF4CAF50),
                onChanged: (v) => onChanged(v, mid, high, reverb, delay),
              ),
              _LabeledSlider(
                label: 'Mid',
                value: mid,
                color: const Color(0xFFFF9800),
                onChanged: (v) => onChanged(low, v, high, reverb, delay),
              ),
              _LabeledSlider(
                label: 'High',
                value: high,
                color: const Color(0xFF03A9F4),
                onChanged: (v) => onChanged(low, mid, v, reverb, delay),
              ),
              const SizedBox(height: 8),
              _LabeledSlider(
                label: 'Reverb',
                value: reverb,
                color: AppTheme.secondary,
                onChanged: (v) => onChanged(low, mid, high, v, delay),
              ),
              _LabeledSlider(
                label: 'Delay',
                value: delay,
                color: AppTheme.primary,
                onChanged: (v) => onChanged(low, mid, high, reverb, v),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({required this.label, required this.value, required this.onChanged, required this.color});
  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyLarge)),
            Text('${(value * 100).round()}%', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Slider(
          value: value,
          onChanged: onChanged,
          activeColor: color,
          inactiveColor: AppTheme.muted.withOpacity(0.3),
        ),
      ],
    );
  }
}

