import 'package:flutter/material.dart';
import 'package:your_project_name/repository/mock/mock_ride_repo.dart';
import 'package:your_project_name/screens/rides/widgets/ride_pref_bar.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';
import 'widgets/rides_tile.dart';

/// The Ride Selection screen allows users to select a ride once ride preferences have been defined.
/// The screen also allows users to redefine ride preferences and activate some filters.
class RidesScreen extends StatefulWidget {
  final RidePref initialRidePref;

  const RidesScreen({super.key, required this.initialRidePref});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late RidePref _currentRidePref;
  RidesFilter? _filter;
  final RidesService _ridesService = RidesService();

  @override
  void initState() {
    super.initState();
    _currentRidePref = widget.initialRidePref;
  }

  // Change the type to List<RideWithPreferences> to filter and display correct rides
  List<RideWithPreferences> get matchingRides {
    return _ridesService
        .getRides(_currentRidePref, _filter)
        .where((ride) => ride is RideWithPreferences)
        .cast<RideWithPreferences>()
        .toList();
  }

  void onRidePrefPressed() {
    // 1- open a modal to edit the ride preferences
    // For now just print a message
    print("Ride preferences editing will be implemented here");
  }

  void onFilterPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildFilterModal(context),
    );
  }

  Widget _buildFilterModal(BuildContext context) {
    bool petAccepted = _filter?.petAccepted ?? false;

    return StatefulBuilder(
      builder: (context, setModalState) {
        return Container(
          padding: const EdgeInsets.all(BlaSpacings.m),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Filters', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: BlaSpacings.m),
              SwitchListTile(
                title: const Text('Pet Accepted'),
                value: petAccepted,
                onChanged: (value) {
                  setModalState(() {
                    petAccepted = value;
                  });
                },
              ),
              const SizedBox(height: BlaSpacings.m),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _filter = RidesFilter(petAccepted: petAccepted);
                  });
                  Navigator.pop(context);
                },
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final rides = matchingRides;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rides'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            // Top search RidePrefBar
            RidePrefBar(
              ridePref: _currentRidePref,
              onRidePrefPressed: onRidePrefPressed,
              onFilterPressed: onFilterPressed,
            ),

            const SizedBox(height: BlaSpacings.m),

            Expanded(
              child: rides.isEmpty
                  ? const Center(
                      child: Text('No rides found matching your criteria'),
                    )
                  : ListView.builder(
                      itemCount: rides.length,
                      itemBuilder: (ctx, index) => RideTile(
                        ride: rides[index], // Passing RideWithPreferences
                        onPressed: () {
                          // Handle ride selection
                          print("Selected ride: ${rides[index]}");
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
