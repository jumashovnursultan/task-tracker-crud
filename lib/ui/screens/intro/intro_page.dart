import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntroPage extends HookConsumerWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(child: Scaffold(body: Column(children: [])));
  }
}
