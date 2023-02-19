import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gre_vocabulary/src/core/extensions.dart';

class VocabularyHomeScreen extends ConsumerWidget {
  const VocabularyHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabulary"),
      ),
      body: Center(
        child: Text(
          "Vocabulary",
          style: context.textTheme.bodyLarge,
        ),
      ),
    );
  }
}
