import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/domain/providers.dart';
import 'package:places/ui/widgets/review.dart';

class ReviewList extends ConsumerWidget {  // ✅ ConsumerWidget
  final int placeId;

  const ReviewList({required this.placeId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(reviewsProvider(placeId));

    return reviewsAsync.when(
      data: (reviews) => Column(
        children: reviews
            .map((review) => Review(reviewInfo: review))  // ✅ Datos dinámicos
            .toList(),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}
