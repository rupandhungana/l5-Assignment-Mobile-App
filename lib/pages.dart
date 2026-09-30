import 'package:flutter/material.dart';
import 'widgets/app_text_field.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageContent(
      title: 'Page 1',
      subtitle: 'Welcome to the first page',
      icon: Icons.home_outlined,
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageContent(
      title: 'Page 2',
      subtitle: 'This is the second page',
      icon: Icons.explore_outlined,
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageContent(
      title: 'Page 3',
      subtitle: 'This is the third page',
      icon: Icons.person_outline,
    );
  }
}

class PageContent extends StatelessWidget {
  const PageContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(icon, size: 72, color: Colors.black87),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 40),
            AppButton(
              label: 'Login',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Sign Up',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
