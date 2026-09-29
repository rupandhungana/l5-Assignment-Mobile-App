import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _sound = false;
  bool _autoUpdate = true;

  void _resetSettings() {
    setState(() {
      _notifications = true;
      _sound = false;
      _autoUpdate = true;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Settings reset to default')));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Card(
              elevation: 0,
              color: colors.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_outlined),
                    title: const Text('Notifications'),
                    value: _notifications,
                    onChanged: (value) =>
                        setState(() => _notifications = value),
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.volume_up_outlined),
                    title: const Text('Sound effects'),
                    value: _sound,
                    onChanged: (value) => setState(() => _sound = value),
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.system_update_outlined),
                    title: const Text('Auto update'),
                    value: _autoUpdate,
                    onChanged: (value) => setState(() => _autoUpdate = value),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => showAboutDialog(
                      context: context,
                      applicationName: 'Buttons & Navigation',
                      applicationVersion: '1.0.0',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextButton.icon(
              onPressed: _resetSettings,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset to default'),
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
