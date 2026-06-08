// lib/ui/widgets/card_image_list.dart - REEMPLAZAR COMPLETO
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/domain/providers.dart';
import 'package:places/ui/widgets/card_image.dart';

class CardImageList extends ConsumerWidget {  // ✅ ConsumerWidget
  const CardImageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);

    return placesAsync.when(
      data: (places) => SizedBox(
        height: 330,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: places
              .map((place) => CardImage(place.images.medium))  // ✅ URLs dinámicas
              .toList(),
        ),
      ),
      loading: () => SizedBox(
        height: 330,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => SizedBox(
        height: 330,
        child: Center(child: Text('Error: $error')),
      ),
    );
  }
}