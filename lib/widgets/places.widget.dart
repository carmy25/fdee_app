import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudiee/main.data.dart';
import 'package:fudiee/models/place/place.model.dart';

class PlaceController extends ValueNotifier<Place?> {
  PlaceController([super.value]);
}

class PlacesWidget extends ConsumerStatefulWidget {
  const PlacesWidget({super.key, required this.controller});

  final PlaceController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlacesWidgetState();
}

class _PlacesWidgetState extends ConsumerState<PlacesWidget> {
  @override
  Widget build(BuildContext context) {
    final placesState = ref.places.watchAll();
    if (placesState.isLoading) {
      return const CircularProgressIndicator();
    }
    final places = placesState.model;
    if (places.isEmpty) {
      return const Text('No places found');
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.2 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, -1),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButton<Place?>(
        value: widget.controller.value,
        hint: const Text(
          'Місце',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        items: [
          const DropdownMenuItem<Place?>(
            value: null,
            child: Text('З собою'),
          ),
          ...places.map((place) {
            return DropdownMenuItem<Place?>(
              value: place,
              child: Text(place.name),
            );
          }),
        ],
        onChanged: (Place? newValue) {
          setState(() {
            widget.controller.value = newValue;
          });
        },
        style: const TextStyle(fontSize: 20),
        dropdownColor: Colors.black,
        iconEnabledColor: Colors.white,
        underline: Container(),
      ),
    );
  }
}
