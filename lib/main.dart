import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/subscription_screen.dart';
import 'screens/mixer_screen.dart';
import 'screens/mixer_vip_screen.dart';
import 'screens/upgrade_homepage_screen.dart';

void main() {
  runApp(const MixerApp());
}

class MixerApp extends StatelessWidget {
  const MixerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mixer UI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const _LauncherScreen(),
      routes: {
        SubscriptionScreen.route: (_) => const SubscriptionScreen(),
        MixerScreen.route: (_) => const MixerScreen(),
        MixerVipScreen.route: (_) => const MixerVipScreen(),
        UpgradeHomepageScreen.route: (_) => const UpgradeHomepageScreen(),
      },
    );
  }
}

class _LauncherScreen extends StatelessWidget {
  const _LauncherScreen();

  @override
  Widget build(BuildContext context) {
    final buttons = [
      _NavButton(label: 'Subscription', route: SubscriptionScreen.route),
      _NavButton(label: 'Mixer', route: MixerScreen.route),
      _NavButton(label: 'Mixer VIP', route: MixerVipScreen.route),
      _NavButton(label: 'Upgrade Homepage', route: UpgradeHomepageScreen.route),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Design Preview Launcher')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: ListView.separated(
              itemCount: buttons.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) => buttons[index],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed(route),
        child: Text(label),
      ),
    );
  }
}

