import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gre_vocabulary/src/core/extensions.dart';
import 'package:gre_vocabulary/src/core/logic/debouncer.dart';
import 'package:gre_vocabulary/src/core/presentation/common_presentation.dart';
import 'package:gre_vocabulary/src/vocabulary/_vocabulary.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/word_details.dart';
import 'package:gre_vocabulary/src/vocabulary/presentation/words_to_be_shown_queue.dart';
import 'package:string_extensions/string_extensions.dart';

import '../domain/entities/word.dart';

part '_search_section.dart';
part '_word_showing_now_section.dart';

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
