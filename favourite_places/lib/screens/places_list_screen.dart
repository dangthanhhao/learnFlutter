import 'package:favourite_places/main.dart';
import 'package:favourite_places/screens/add_place_screen.dart';
import 'package:favourite_places/screens/place_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/places_provider.dart';

class PlaceListScreen extends ConsumerWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultStyle =
        theme.textTheme.titleLarge!.copyWith(color: colorScheme.onBackground);
    Widget content = Center(
      child: Text(
        'No places added yet',
        style: defaultStyle,
      ),
    );
    final places = ref.watch(placesProvider);
    if (places.isNotEmpty) {
      content = ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            places[index].title,
            style: defaultStyle,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlaceDetailsScreen(place: places[index]),
            ));
          },
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
