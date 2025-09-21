import 'package:cgheven/screens/utils/apptheme.dart';
import 'package:flutter/material.dart';

class GradientSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const GradientSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 50,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: value
                ? AppTheme.fireGradient
                : LinearGradient(
                    colors: [Colors.grey.shade700, Colors.grey.shade800],
                  ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.transparent,
          activeTrackColor: Colors.transparent,
        ),
      ],
    );
  }
}
