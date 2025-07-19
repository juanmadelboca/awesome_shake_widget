import 'package:awesome_shake_widget/enum/shake_preset.dart';
import 'package:awesome_shake_widget/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:shake_widget_example/widgets/custom_button.dart';

final GlobalKey<ShakeWidgetState> customKey = GlobalKey();

void showCustomDialog({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) {
      return ShakeWidget(
        key: customKey,
        preset: ShakePreset.heavy,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ready to Shake?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'This will trigger a custom shake animation along with vibration feedback. Press the button below to proceed.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Close',
                      textColor: Colors.black,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    CustomButton(
                      onPressed: () {
                        customKey.currentState?.shake();
                      },
                      text: 'Shake',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
