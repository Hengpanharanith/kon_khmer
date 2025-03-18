import 'package:flutter/material.dart';
import 'package:your_project_name/model/ride_pref/ride_pref.dart';

class RidePrefSummary extends StatelessWidget {
  final RidePreference preferences;
  final VoidCallback onEdit;

  const RidePrefSummary({
    Key? key,
    required this.preferences,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          '${preferences.departure} → ${preferences.arrival}, ${preferences.departureDate}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}