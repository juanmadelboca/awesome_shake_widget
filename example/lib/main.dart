import 'package:awesome_shake_widget/enum/shake_preset.dart';
import 'package:awesome_shake_widget/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:shake_widget_example/widgets/custom_button.dart';
import 'package:shake_widget_example/widgets/custom_dialog.dart';
import 'package:shake_widget_example/widgets/custom_form.dart';
import 'package:shake_widget_example/widgets/custome_network_image.dart';

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
                child: CustomButton(
                  onPressed: () => lightKey.currentState?.shake(),
                  text: "Light Shake",
                  icon: Icons.vibration,
                ),
              ),
              const SizedBox(height: 15),
              Divider(),
              const SizedBox(height: 15),
              Text("This form will shake if any value is empty"),
              const SizedBox(height: 15),
              ShakeWidget(
                key: mediumKey,
                preset: ShakePreset.medium,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: CustomForm(
                    onEmpty: (first, second) => mediumKey.currentState?.shake(),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Divider(),
              const SizedBox(height: 15),
              Text("Image will shake on load finished"),
              const SizedBox(height: 15),
              ShakeWidget(
                key: heavyKey,
                preset: ShakePreset.heavy,
                child: CustomNetworkImage(
                  onLoaded: () => heavyKey.currentState?.shake(),
                ),
              ),
              const SizedBox(height: 15),
              Divider(),
              const SizedBox(height: 15),
              CustomButton(
                onPressed: () => showCustomDialog(context: context),
                text: 'Trigger Heavy Shake',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
