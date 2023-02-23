import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gre_vocabulary/src/core/extensions.dart';
import 'package:gre_vocabulary/src/core/logic/debouncer.dart';
import 'package:gre_vocabulary/src/core/presentation/common_presentation.dart';
import 'package:gre_vocabulary/src/vocabulary/_vocabulary.dart';

import '../domain/entities/word.dart';

part '_search_section.dart';

class VocabularyHomeScreen extends ConsumerWidget {
  const VocabularyHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: const [
          DashboardSearchSection(),
          WordShowingNowSection(),
        ],
      ),
    );
  }
}

class WordShowingNowSection extends StatelessWidget {
  const WordShowingNowSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        children: [
          const Text(
            "Word showing now",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Word showing now",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
