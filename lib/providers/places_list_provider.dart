import 'dart:io';

import 'package:favorite_place_app/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPlacesNotifer extends StateNotifier<List<Place>> {
  ListPlacesNotifer() : super(const []);

  void addNewPlace(String title, File image) {
    state = [Place(title: title, image: image), ...state];
  }
}

final listPlacesProvider = StateNotifierProvider<ListPlacesNotifer, List<Place>>((ref) => ListPlacesNotifer());
