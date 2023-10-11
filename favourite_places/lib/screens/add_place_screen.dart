import 'package:favourite_places/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/places_provider.dart';

class AddPlaceScreen extends ConsumerWidget {
  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.read(placesProvider.notifier);
    String title = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text('Title')),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                title = value;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  list.addPlace(title);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Place')),
          ],
        ),
      ),
    );
  }
}
