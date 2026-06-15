import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/domain/providers.dart';

class FabGreen extends ConsumerWidget {
  final int placeId;

  const FabGreen({required this.placeId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final isFav = favorites.contains(placeId);

    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Color(0xFF16db58),
      mini: true,
      tooltip: isFav ? "Quitar de favoritos" : "Agregar a favoritos",
      shape: CircleBorder(),
      onPressed: () {
        ref.read(favoritesProvider.notifier).toggle(placeId);
      },
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.white,
      ),
    );
  }
}