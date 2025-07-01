import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.appBarTheme.backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "© 2025 Dausen Mason",
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.appBarTheme.foregroundColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Demo App for Event Ticket Booking",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.appBarTheme.foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
