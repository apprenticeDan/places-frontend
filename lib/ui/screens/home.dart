import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/domain/providers.dart';
import 'package:places/ui/widgets/home_app_bar.dart';
import 'package:places/ui/widgets/review_list.dart';
import 'package:places/ui/widgets/description_place.dart';
import 'package:places/ui/widgets/add_review_dialog.dart';

class MyHome extends ConsumerWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);

    return placesAsync.when(
      data: (places) {
        if (places.isEmpty) {
          return Scaffold(
            body: Center(child: Text('No hay lugares disponibles')),
          );
        }

        final place = places.first;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF574ACF),
            child: const Icon(Icons.rate_review, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AddReviewDialog(placeId: place.id),
              );
            },
          ),
          body: Stack(
            children: [
              ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 330, left: 30, right: 30),
                    child: DescriptionPlace(
                      place.name,
                      place.rating,
                      place.description,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: ReviewList(placeId: place.id),
                  ),
                ],
              ),
              HomeAppBar(place.name),
            ],
          ),
        );
      },
      loading: () => Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}