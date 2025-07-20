import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String? text;
  final double height;

  const CustomDivider({super.key, this.text, this.height = 15});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: Divider(thickness: 1)),
            if (text != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  text!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            Expanded(child: Divider(thickness: 1)),
          ],
        ),
        SizedBox(height: height),
      ],
    );
  }
}
