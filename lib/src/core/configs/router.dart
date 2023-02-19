import 'package:go_router/go_router.dart';
import 'package:gre_vocabulary/src/onboarding/presentation/onboarding_screen.dart';
import 'package:gre_vocabulary/src/onboarding/presentation/splash_screen.dart';
import 'package:gre_vocabulary/src/vocabulary/_vocabulary.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.home,
      builder: (context, state) => const VocabularyHomeScreen(),
    ),
  ],
);

class AppRoutePaths {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
}
