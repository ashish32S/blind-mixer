import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_button.dart';

class MixerVipScreen extends StatelessWidget {
  const MixerVipScreen({super.key});

  static const String route = '/mixer-vip';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0B0C10), Color(0xFF151922)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.card,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.workspace_premium, color: AppTheme.accent, size: 18),
                            const SizedBox(width: 8),
                            Text('VIP', style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Exclusive VIP Mixer', style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 8),
                  Text('Unlock premium chains, AI mastering presets, and golden themes.', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.1,
                      children: const [
                        _VipCard(icon: Icons.auto_awesome, title: 'AI Mastering', desc: 'One-tap polish to radio-ready.'),
                        _VipCard(icon: Icons.equalizer, title: 'Pro Chains', desc: 'Curated by top engineers.'),
                        _VipCard(icon: Icons.brush, title: 'Gold Themes', desc: 'Luxury skins for your setup.'),
                        _VipCard(icon: Icons.lock_clock, title: 'Priority Access', desc: 'Fast rendering queue.'),
                        _VipCard(icon: Icons.cloud_download, title: 'HQ Exports', desc: 'Lossless multi-track stems.'),
                        _VipCard(icon: Icons.school, title: 'VIP Tutorials', desc: 'Advanced production lessons.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GradientButton(label: 'Upgrade to VIP', onPressed: () {}),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _VipCard extends StatelessWidget {
  const _VipCard({required this.icon, required this.title, required this.desc});
  final IconData icon;
  final String title;
  final String desc;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.accent, Colors.white]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black),
            ),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(desc, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

