import 'package:flutter/material.dart';

class CustomNetworkImage extends StatefulWidget {
  final void Function() onLoaded;

  const CustomNetworkImage({super.key, required this.onLoaded});

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  Key _imageKey = UniqueKey();
  bool _hasShaken = false;

  void _reloadImage() {
    setState(() {
      _imageKey = UniqueKey(); // Forces reload
      _hasShaken = false; // Allow shaking again
    });
  }

  void _onImageFullyLoaded() {
    if (!_hasShaken) {
      _hasShaken = true;

      // Shake after build completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onLoaded();
      });

      // Call external callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://play-lh.googleusercontent.com/Mvv0TtJnjkifWYniDwa14anwamrgawp9h7cfAMT7RD0G7IgGM01uGxZKBCQ8YEnb3ejH=w7680-h4320-rw',
              key: _imageKey,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  _onImageFullyLoaded();
                }
                return child;
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 48);
              },
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: _reloadImage,
              icon: const Icon(Icons.refresh, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
