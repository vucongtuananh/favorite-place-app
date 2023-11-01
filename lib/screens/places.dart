import 'package:favorite_place_app/screens/add_place.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
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
      body: const PlacesScreen(),
    );
  }
}
