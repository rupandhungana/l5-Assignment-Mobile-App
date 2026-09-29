import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/section_card.dart';
import 'add_screen.dart';
import 'profile_screen.dart';

class ButtonGalleryScreen extends StatefulWidget {
  const ButtonGalleryScreen({super.key});

  @override
  State<ButtonGalleryScreen> createState() => _ButtonGalleryScreenState();
}

class _ButtonGalleryScreenState extends State<ButtonGalleryScreen> {
  final List<String> _items = [];
  bool _isFavorite = false;
  bool _isBookmarked = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  // Navigator.push() with MaterialPageRoute
  void _openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  // Navigator.push() that waits for a value sent back with Navigator.pop()
  Future<void> _openAddScreen() async {
    final newItem = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AddScreen()),
    );
    if (!mounted || newItem == null) return;
    setState(() => _items.add(newItem));
    _showMessage('Added "$newItem"');
  }

  // Navigator.pushReplacementNamed(): Gallery is replaced by Login, so the
  // user can't press Back to return to the gallery after logging out.
  void _logout() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  void _showHelp() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.help_outline),
        title: const Text('How it works'),
        content: const Text(
          'Each button shows the widget used and the navigation method it '
          'calls. Try them and use Back to return to the gallery.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Gallery'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: _openProfile,
          ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddScreen,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            SectionCard(
              title: 'Common Buttons',
              subtitle: 'The five main Material 3 button types',
              child: Column(
                children: [
                  ButtonDemoRow(
                    name: 'ElevatedButton',
                    action: 'push() → Profile',
                    button: ElevatedButton(
                      onPressed: _openProfile,
                      child: const Text('Profile'),
                    ),
                  ),
                  ButtonDemoRow(
                    name: 'FilledButton',
                    action: 'pushNamed() → Details',
                    button: FilledButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.details,
                        arguments: 'FilledButton in the Button Gallery',
                      ),
                      child: const Text('Details'),
                    ),
                  ),
                  ButtonDemoRow(
                    name: 'FilledButton.tonal',
                    action: 'pushNamed() → Settings',
                    button: FilledButton.tonal(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.settings),
                      child: const Text('Settings'),
                    ),
                  ),
                  ButtonDemoRow(
                    name: 'OutlinedButton',
                    action: 'push() → Add, gets result',
                    button: OutlinedButton(
                      onPressed: _openAddScreen,
                      child: const Text('Add Item'),
                    ),
                  ),
                  ButtonDemoRow(
                    name: 'TextButton',
                    action: 'showDialog()',
                    button: TextButton(
                      onPressed: _showHelp,
                      child: const Text('Help'),
                    ),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Buttons with Icons',
              subtitle: 'Using the .icon() constructors',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.profile),
                    icon: const Icon(Icons.person_outline),
                    label: const Text('My Profile'),
                  ),
                  FilledButton.icon(
                    onPressed: () => _showMessage('Downloading report...'),
                    icon: const Icon(Icons.download),
                    label: const Text('Download'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _showMessage('Link copied to share'),
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Share'),
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.details,
                      arguments: 'TextButton.icon',
                    ),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('More Info'),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Icon Buttons',
              subtitle: 'Standard, filled, tonal and outlined',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    tooltip: 'Favorite',
                    isSelected: _isFavorite,
                    icon: const Icon(Icons.favorite_border),
                    selectedIcon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      setState(() => _isFavorite = !_isFavorite);
                      _showMessage(
                        _isFavorite
                            ? 'Added to favorites'
                            : 'Removed from favorites',
                      );
                    },
                  ),
                  IconButton.filled(
                    tooltip: 'Bookmark',
                    isSelected: _isBookmarked,
                    icon: const Icon(Icons.bookmark_border),
                    selectedIcon: const Icon(Icons.bookmark),
                    onPressed: () {
                      setState(() => _isBookmarked = !_isBookmarked);
                      _showMessage(
                        _isBookmarked ? 'Bookmarked' : 'Bookmark removed',
                      );
                    },
                  ),
                  IconButton.filledTonal(
                    tooltip: 'Settings',
                    icon: const Icon(Icons.tune),
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.settings),
                  ),
                  IconButton.outlined(
                    tooltip: 'Clear items',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      setState(_items.clear);
                      _showMessage('All items cleared');
                    },
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Sizes',
              subtitle: 'Same button with different padding and text size',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FilledButton(
                        onPressed: () => _showMessage('Small button tapped'),
                        style: FilledButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        child: const Text('Small'),
                      ),
                      const SizedBox(width: 12),
                      FilledButton(
                        onPressed: () => _showMessage('Medium button tapped'),
                        child: const Text('Medium'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.details,
                        arguments: 'Large full-width button',
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Large · Open Details'),
                    ),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Custom Styled',
              subtitle: 'Gradient pill button · pushReplacementNamed()',
              child: GradientButton(
                label: 'Logout',
                icon: Icons.logout,
                onPressed: _logout,
              ),
            ),
            if (_items.isNotEmpty)
              SectionCard(
                title: 'Added Items (${_items.length})',
                subtitle: 'Values returned from the Add screen with pop()',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final item in _items)
                      Chip(
                        label: Text(item),
                        backgroundColor: colors.secondaryContainer,
                        side: BorderSide.none,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
