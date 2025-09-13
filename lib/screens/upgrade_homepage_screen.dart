import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_button.dart';

class UpgradeHomepageScreen extends StatelessWidget {
  const UpgradeHomepageScreen({super.key});

  static const String route = '/upgrade-home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0E0F13), Color(0xFF1A1C22)],
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isWide = constraints.maxWidth > 900;
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Mixer', style: Theme.of(context).textTheme.titleLarge),
                                const Spacer(),
                                TextButton(onPressed: () {}, child: const Text('Pricing')),
                                const SizedBox(width: 8),
                                TextButton(onPressed: () {}, child: const Text('Login')),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Text('Upgrade your sound', style: Theme.of(context).textTheme.headlineLarge),
                            const SizedBox(height: 10),
                            Text('Premium tools to mix, master, and publish faster.', style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(height: 20),
                            SizedBox(width: 320, child: GradientButton(label: 'Upgrade Now', onPressed: () {})),
                            const SizedBox(height: 24),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: const [
                                _BenefitChip(icon: Icons.speed, label: 'Faster queue'),
                                _BenefitChip(icon: Icons.hd, label: 'High quality'),
                                _BenefitChip(icon: Icons.lock, label: 'Private exports'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isWide)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Card(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppTheme.radius),
                                gradient: const LinearGradient(colors: [AppTheme.primary, AppTheme.secondary]),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('Preview', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black)),
                                  const SizedBox(height: 12),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(child: Icon(Icons.music_note, color: Colors.white54, size: 64)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitChip extends StatelessWidget {
  const _BenefitChip({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.secondary),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

