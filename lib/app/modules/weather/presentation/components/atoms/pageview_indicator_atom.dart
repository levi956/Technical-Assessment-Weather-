import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/provider/persisted_locations_provider.dart';

class PageviewIndicator extends HookConsumerWidget {
  final int currentIndex;
  const PageviewIndicator({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityStore = ref.watch(localCitiesProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(cityStore.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(
            horizontal: 4.0,
          ),
          height: 4.0,
          width: currentIndex == index ? 16.0 : 10.0,
          decoration: BoxDecoration(
            color:
                currentIndex == index ? const Color(0xff161455) : Colors.grey,
            borderRadius: BorderRadius.circular(6.0),
          ),
        );
      }),
    );
  }
}
