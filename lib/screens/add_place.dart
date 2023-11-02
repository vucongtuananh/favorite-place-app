import 'dart:io';

import 'package:favorite_place_app/providers/places_list_provider.dart';
import 'package:favorite_place_app/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaces extends ConsumerStatefulWidget {
  const AddPlaces({super.key});

  @override
  ConsumerState<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends ConsumerState<AddPlaces> {
  File? pickImage;
  final placeInput = TextEditingController();
  @override
  void dispose() {
    placeInput.dispose();
    super.dispose();
  }

  void addPlace() {
    if (placeInput.text.isEmpty || pickImage == null) {
      return;
    }
    ref.read(listPlacesProvider.notifier).addNewPlace(placeInput.text, pickImage!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your place"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              TextField(
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                controller: placeInput,
                decoration: const InputDecoration(label: Text("Add your place's name (1-50 characters)")),
              ),
              const SizedBox(
                height: 12,
              ),
              ImageInput(
                onPickImage: (File image) {
                  pickImage = image;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton.icon(onPressed: addPlace, icon: const Icon(Icons.add), label: const Text("Submit"))
            ],
          )),
    );
  }
}
