import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gre_vocabulary/src/core/extensions.dart';

import '../onboarding_di.dart';

class OnboardingScreen extends ConsumerWidget {
  static const routePath = "/onboarding";

  const OnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Onboarding",
              style: context.textTheme.bodyLarge,
            ),
            ElevatedButton(
              onPressed: () => _markOnboardingDone(ref),
              child: Text("Mark onboarding done"),
            ),
          ],
        ),
      ),
    );
  }

  void _markOnboardingDone(WidgetRef ref) {
    final onboardingController =
        ref.read(onboardingControllerProvider.notifier);
    onboardingController.markOnboardingCompleted();
  }
}
