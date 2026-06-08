import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/domain/providers.dart';
import 'package:places/ui/widgets/home_app_bar.dart';
import 'package:places/ui/widgets/review_list.dart';
import 'package:places/ui/widgets/description_place.dart';
import 'package:places/ui/widgets/card_image_list.dart';

class MyHome extends ConsumerWidget {  // ✅ ConsumerWidget
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

        final place = places.first;  // O usar parámetro de ID

        return Scaffold(
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
              HomeAppBar(place.name),  // ✅ Nombre dinámico
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