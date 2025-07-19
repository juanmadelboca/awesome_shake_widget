import 'package:flutter/material.dart';
import 'package:awesome_shake_widget/enum/shake_preset.dart';
import 'package:awesome_shake_widget/enum/vibration_type.dart';
import 'package:awesome_shake_widget/shake_config.dart';
import 'package:awesome_shake_widget/shake_widget.dart';

void main() {
  runApp(const ShakeExampleApp());
}

class ShakeExampleApp extends StatelessWidget {
  const ShakeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShakeExamplePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ShakeExamplePage extends StatelessWidget {
  final GlobalKey<ShakeWidgetState> lightKey = GlobalKey();
  final GlobalKey<ShakeWidgetState> mediumKey = GlobalKey();
  final GlobalKey<ShakeWidgetState> heavyKey = GlobalKey();
  final GlobalKey<ShakeWidgetState> customKey = GlobalKey();

  final TextEditingController lightController = TextEditingController();
  final TextEditingController mediumController = TextEditingController();
  final TextEditingController heavyController = TextEditingController();
  final TextEditingController customController = TextEditingController();

  ShakeExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ShakeWidget Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ShakeWidget(
                key: lightKey,
                preset: ShakePreset.light,
                child: CustomTextField(
                  controller: lightController,
                  hintText: 'Light Shake',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => lightKey.currentState?.shake(),
                child: const Text('Trigger Light Shake'),
              ),
              const SizedBox(height: 30),
              ShakeWidget(
                key: mediumKey,
                preset: ShakePreset.medium,
                child: CustomTextField(
                  controller: mediumController,
                  hintText: 'Medium Shake',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => mediumKey.currentState?.shake(),
                child: const Text('Trigger Medium Shake'),
              ),
              const SizedBox(height: 30),
              ShakeWidget(
                key: heavyKey,
                preset: ShakePreset.heavy,
                child: CustomTextField(
                  controller: heavyController,
                  hintText: 'Heavy Shake',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => heavyKey.currentState?.shake(),
                child: const Text('Trigger Heavy Shake'),
              ),
              const SizedBox(height: 30),
              ShakeWidget(
                key: customKey,
                preset: ShakePreset.custom,
                customConfig: const ShakeConfig(
                  offset: 36,
                  pattern: [0, 40, 80, 40, 120, 40],
                  intensities: [255, 0, 180, 0, 180, 0],
                  vibrationType: VibrationType.custom,
                ),
                child: CustomTextField(
                  controller: customController,
                  hintText: 'Custom Shake',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => customKey.currentState?.shake(),
                child: const Text('Trigger Custom Shake'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color(0xFFF3F1EC),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
