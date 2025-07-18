library;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake_widget/shake_config.dart';
import 'package:vibration/vibration.dart';

import 'enum/shake_preset.dart';
import 'enum/vibration_type.dart';

class ShakeWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final ShakePreset preset;
  final ShakeConfig? customConfig;

  const ShakeWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.preset = ShakePreset.heavy,
    this.customConfig,
  });

  @override
  ShakeWidgetState createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ShakeConfig config;

  @override
  void initState() {
    super.initState();
    config = widget.preset == ShakePreset.custom && widget.customConfig != null
        ? widget.customConfig!
        : ShakeConfig.fromPreset(widget.preset);

    _controller = AnimationController(duration: widget.duration, vsync: this);

    final curved = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
    _animation = Tween(begin: 0.0, end: config.offset).animate(curved)..addListener(() => setState(() {}));
  }

  Future<void> shake() async {
    _controller.forward(from: 0.0);

    switch (config.vibrationType) {
      case VibrationType.none:
        return;
      case VibrationType.haptic:
        HapticFeedback.heavyImpact();
        break;
      case VibrationType.custom:
        try {
          final supportsPattern = await Vibration.hasCustomVibrationsSupport();
          if (supportsPattern && config.pattern != null && config.intensities != null) {
            await Vibration.vibrate(
              pattern: config.pattern ?? [0, 40, 80, 40, 80, 40],
              intensities: config.intensities ?? [180, 0, 180, 0, 180, 0],
            );
          } else {
            HapticFeedback.mediumImpact();
          }
        } catch (_) {
          HapticFeedback.mediumImpact();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(offset: Offset(_animation.value * math.sin(_controller.value * math.pi * 4), 0), child: widget.child);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
