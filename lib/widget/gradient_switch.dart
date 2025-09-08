import 'package:flutter/material.dart';

class GradientSwitch extends StatelessWidget {
  final bool value;
  final Function? onChanged;

  const GradientSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [Color(0xFF2A7B9B), Color(0xFF57C785), Color(0xFFEDDD53)],
          stops: [0.0, 0.5, 1.0],
        ).createShader(bounds);
      },
      child: Switch(
        value: value,
        onChanged: (_) => onChanged,
        inactiveThumbColor: Colors.grey[400],
        inactiveTrackColor: Colors.grey[600],
        activeTrackColor: Colors.white, // will be masked by gradient
        activeColor: Colors.white, // thumb will show gradient
      ),
    );
  }
}
