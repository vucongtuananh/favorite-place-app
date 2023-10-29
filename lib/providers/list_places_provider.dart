import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPlacesProvider extends StateNotifier<List<String>> {
  ListPlacesProvider() : super([]);

  void addPlace(String placeName) {
    state = [...state, placeName];
  }
}

final listPlacesProvider = StateNotifierProvider<ListPlacesProvider, List<String>>((ref) {
  return ListPlacesProvider();
});
