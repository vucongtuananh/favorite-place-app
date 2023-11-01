import 'package:favorite_place_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPlacesNotifer extends StateNotifier<List<Place>> {
  ListPlacesNotifer() : super(const []);

  void addNewPlace(String title) {
    state = [Place(title: title), ...state];
  }
}

final listPlacesProvider = StateNotifierProvider<ListPlacesNotifer, List<Place>>((ref) => ListPlacesNotifer());
