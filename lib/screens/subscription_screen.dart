import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_button.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  static const String route = '/subscription';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 600;
          final EdgeInsets pagePadding = EdgeInsets.symmetric(
            horizontal: isWide ? 48 : 20,
            vertical: 20,
          );

          return SingleChildScrollView(
            padding: pagePadding,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Header(),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: const [
                        _PlanCard(title: 'Basic', price: 'Free', features: [
                          'Limited mixes per day',
                          'Standard quality',
                        ]),
                        _PlanCard(title: 'Pro', price: '\$9.99/mo', highlighted: true, features: [
                          'Unlimited mixes',
                          'High quality output',
                          'Priority queue',
                        ]),
                        _PlanCard(title: 'Studio', price: '\$19.99/mo', features: [
                          'All Pro features',
                          'Multi-track export',
                          'Early access',
                        ]),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const _FaqSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose your plan', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text(
          'Access premium features and get the best out of Mixer.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.features,
    this.highlighted = false,
  });

  final String title;
  final String price;
  final List<String> features;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = highlighted ? AppTheme.accent : Colors.transparent;
    final Color chipColor = highlighted ? AppTheme.accent : AppTheme.card;
    return SizedBox(
      width: 280,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius),
          side: BorderSide(color: borderColor, width: highlighted ? 1.2 : 0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(title, style: Theme.of(context).textTheme.titleLarge),
                  ),
                  if (highlighted)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: chipColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text('Popular', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black)),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(price, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              for (final f in features)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppTheme.secondary, size: 20),
                      const SizedBox(width: 10),
                      Expanded(child: Text(f, style: Theme.of(context).textTheme.bodyLarge)),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              GradientButton(label: highlighted ? 'Upgrade to Pro' : 'Choose plan', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FAQ', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        const _FaqItem(q: 'Can I cancel anytime?', a: 'Yes, you can cancel from settings and continue until the end of your billing period.'),
        const _FaqItem(q: 'Is there a trial?', a: 'We offer a 7-day free trial for the Pro plan.'),
        const _FaqItem(q: 'Do you offer student discounts?', a: 'Yes, contact support to verify your eligibility.'),
      ],
    );
  }
}

class _FaqItem extends StatelessWidget {
  const _FaqItem({required this.q, required this.a});
  final String q;
  final String a;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(q, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(a, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

