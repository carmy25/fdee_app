import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final placesState = ref.places.watchAll(syncLocal: true, remote: true);
    if (placesState.isLoading) {
      return const CircularProgressIndicator();
    }
    final places = placesState.model;

    // Find the selected place from the places list if there is a selected value
    Place? selectedPlace;
    if (widget.controller.value != null) {
      selectedPlace = places.firstWhere(
        (p) => p.id == widget.controller.value?.id,
        orElse: () => widget.controller.value!,
      );
    }

    // Create menu items including the "З собою" option
    final List<DropdownMenuItem<Place?>> menuItems = [
      DropdownMenuItem<Place?>(
        value: null,
        child: Text(
          'З собою',
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
      ),
      ...places.map((e) => DropdownMenuItem<Place?>(
            value: e,
            child: Text(
              e.name,
              style: TextStyle(fontSize: 20.sp, color: Colors.white),
            ),
          )),
    ];

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
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: DropdownButton<Place?>(
        value: selectedPlace,
        hint: Text(
          'Місце',
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        items: menuItems,
        onChanged: (Place? newValue) {
          setState(() {
            widget.controller.value = newValue;
          });
        },
        style: TextStyle(fontSize: 20.sp, color: Colors.white),
        dropdownColor: Colors.black,
        iconEnabledColor: Colors.white,
        underline: Container(),
      ),
    );
  }
}
