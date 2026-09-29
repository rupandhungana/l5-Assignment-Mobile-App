import 'package:flutter/material.dart';

import '../routes.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    // Optional value passed with Navigator.pushNamed(..., arguments: ...).
    final openedFrom = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Icon(Icons.layers_outlined, size: 64, color: colors.primary),
            const SizedBox(height: 16),
            Text(
              'The Navigation Stack',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Flutter keeps screens in a stack. push() adds a screen on top, '
              'pop() removes the top screen, and pushReplacement() swaps the '
              'top screen for a new one.',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 0,
              color: colors.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.route_outlined),
                    title: const Text('Opened with'),
                    subtitle: const Text("Navigator.pushNamed('/details')"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.touch_app_outlined),
                    title: const Text('Opened from'),
                    subtitle: Text(openedFrom ?? 'Unknown'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              // Adds another screen on top to show the stack growing.
              onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
              icon: const Icon(Icons.person_outline),
              label: const Text('Open Profile on top'),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              // Navigator.pop(): return to the previous screen.
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
