import 'enum/shake_preset.dart';
import 'enum/vibration_type.dart';

class ShakeConfig {
  final double offset;
  final List<int>? pattern;
  final List<int>? intensities;
  final VibrationType vibrationType;

  const ShakeConfig({required this.offset, this.pattern, this.intensities, this.vibrationType = VibrationType.haptic});

  factory ShakeConfig.fromPreset(ShakePreset preset) {
    switch (preset) {
      case ShakePreset.light:
        return const ShakeConfig(offset: 8, vibrationType: VibrationType.haptic);
      case ShakePreset.medium:
        return const ShakeConfig(offset: 16, vibrationType: VibrationType.haptic);
      case ShakePreset.heavy:
        return const ShakeConfig(offset: 24, pattern: [0, 60, 100, 60], intensities: [180, 0, 180, 0], vibrationType: VibrationType.custom);
      case ShakePreset.custom:
        return const ShakeConfig(
          offset: 24,
          pattern: [0, 40, 80, 40, 80, 40],
          intensities: [180, 0, 180, 0, 180, 0],
          vibrationType: VibrationType.custom,
        );
    }
  }
}
