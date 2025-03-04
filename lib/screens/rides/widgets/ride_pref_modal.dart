import 'package:flutter/material.dart';
import 'package:your_project_name/screens/ride_pref/widgets/ride_pref_form.dart';
import '../../../model/ride_pref/ride_pref.dart';


class RidePrefModal extends StatelessWidget {
  final RidePref initialPreferences;
  final Function(RidePref) onSave;

  const RidePrefModal({
    Key? key,
    required this.initialPreferences,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Edit Ride Preferences',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16.0),
          RidePrefForm(
            initRidePref: initialPreferences,
          ),
        ],
      ),
    );
  }
}

void showRidePrefModal(BuildContext context, RidePref initialPreferences, Function(RidePref) onSave) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => RidePrefModal(
      initialPreferences: initialPreferences,
      onSave: onSave,
    ),
  );
}
