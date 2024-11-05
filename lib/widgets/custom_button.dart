import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget screen;

  const CustomButton({
    super.key,
    required this.icon,
    required this.text,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      icon: Icon(icon, size: 32.0), // Increase icon size
      label: Text(
        text,
        style: const TextStyle(fontSize: 20.0), // Increase text size
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0), // Increase padding
        textStyle: const TextStyle(fontSize: 20.0), // Increase text size
      ),
    );
  }
}