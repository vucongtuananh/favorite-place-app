import 'package:favorite_place_app/providers/list_places_provider.dart';
import 'package:favorite_place_app/screens/add_places.dart';
import 'package:favorite_place_app/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourPlaces extends ConsumerWidget {
  const YourPlaces({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final listPlaces = ref.watch(listPlacesProvider);
    bool isBlank = listPlaces.isEmpty;
    Widget content = Center(
      child: Text(
        "No places added yet!!",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
    if (!isBlank) {
      content = ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetails(
                      titleAppBar: listPlaces[index],
                    ),
                  ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSurface, borderRadius: BorderRadius.circular(12)),
              child: Text(
                listPlaces[index],
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.background),
              ),
            ),
          );
        },
        itemCount: listPlaces.length,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your places"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPlaces(),
                    ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
