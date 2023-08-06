import 'package:flutter/material.dart';
import '../values/colors.dart';

class VoiceInputButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isListening;

  const VoiceInputButton(
      {required this.onPressed, required this.isListening, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isListening ? onSurfaceMicListening : onSurfaceMicNotListening,
      onPressed: onPressed,
      icon: Icon(isListening ? Icons.mic : Icons.mic_none),
    );
  }
}
