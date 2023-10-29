import 'package:favorite_place_app/providers/list_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaces extends ConsumerStatefulWidget {
  const AddPlaces({super.key});

  @override
  ConsumerState<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends ConsumerState<AddPlaces> {
  var _placeName = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final listPlace = ref.watch(listPlacesProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your place!!"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().length >= 50) {
                    return "No ok bro";
                  }
                },
                style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                onSaved: (newValue) {
                  _placeName = newValue!;
                },
                maxLength: 50,
                decoration: const InputDecoration(label: Text("Your place(1-50 characters)")),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      listPlace.addPlace(_placeName);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Submit !!"))
            ]),
          )),
    );
  }
}
