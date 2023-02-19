// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class InitializerApp extends ConsumerWidget {
//   const InitializerApp({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final services = ref.watch(initializer);
//     return services.when(
//       data: (data) {
//         return ProviderScope(
//           overrides: [
//             vocabularyControllerProvider.overrideWith(
//                   (ref) =>
//                   VocabularyController(service: data.vocabularyServiceFacade),
//             ),
//             onboardingControllerProvider.overrideWith(
//                   (ref) => OnboardingController(service: data.onboardingService),
//             ),
//           ],
//           child: const _SplashDisplay(),
//         );
//       },
//       error: (_, __) => Scaffold(
//         body: Container(
//           color: Colors.red,
//           child: const Center(
//             child: Text(
//               "Vocabulary",
//               style: TextStyle(fontSize: 30),
//             ),
//           ),
//         ),
//       ),
//       loading: () => const _SplashDisplay(),
//     );
//   }
// }
