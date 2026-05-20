import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.primaryColor, size: 18),
        const SizedBox(width: 8),
        Text('$label: ',
            style: const TextStyle(
                color: Colors.white70, fontWeight: FontWeight.w600)),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}