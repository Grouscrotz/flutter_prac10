import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final int counter;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.counter,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Text(label),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
            child: Text('$counter', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}