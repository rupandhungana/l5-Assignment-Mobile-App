import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Rupan Dhungana';

  Future<void> _editName() async {
    final controller = TextEditingController(text: _name);
    // The dialog closes with Navigator.pop(), returning the new name.
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (newName != null && newName.isNotEmpty) {
      setState(() => _name = newName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: colors.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 56,
                  color: colors.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _name,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
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
                    leading: const Icon(Icons.badge_outlined),
                    title: const Text('Name'),
                    subtitle: Text(_name),
                  ),
                  const ListTile(
                    leading: Icon(Icons.school_outlined),
                    title: Text('Role'),
                    subtitle: Text('Student'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.mail_outline),
                    title: Text('Email'),
                    subtitle: Text('rupandhungana@gmail.com'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _editName,
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit Profile'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
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
