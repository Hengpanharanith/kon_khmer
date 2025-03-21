import 'package:flutter/material.dart';
import 'package:your_project_name/repository/mock/mock_ride_repo.dart';
import '../../../theme/theme.dart';
import '../../../utils/date_time_util.dart';
class RideTile extends StatelessWidget {
  final RideWithPreferences ride; // Use RideWithPreferences type
  final VoidCallback onPressed;

  const RideTile({super.key, required this.ride, required this.onPressed});

  String get departure => "Departure: ${ride.departureLocation.name}";
  String get arrival => "Arrival: ${ride.arrivalLocation.name}";
  String get time => "Time: ${DateTimeUtils.formatTime(ride.departureDate)}";
  String get price => "Price per seat: \$${ride.pricePerSeat}";
  String get driver =>
      "Driver: ${ride.driver.firstName} ${ride.driver.lastName}";
  String get seats => "Available seats: ${ride.availableSeats}";
  String get petFriendly =>
      ride.acceptPets ? "Pets allowed" : "No pets allowed";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(departure,
                  style: BlaTextStyles.label
                      .copyWith(color: BlaColors.textNormal)),
              Text(arrival,
                  style: BlaTextStyles.label
                      .copyWith(color: BlaColors.textNormal)),
              Text(time,
                  style: BlaTextStyles.label
                      .copyWith(color: BlaColors.textNormal)),
              Text(price,
                  style: BlaTextStyles.label
                      .copyWith(color: BlaColors.textNormal)),
              const Divider(),
              Text(driver,
                  style:
                      BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
              Text(seats,
                  style:
                      BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
              Text(petFriendly,
                  style: BlaTextStyles.label.copyWith(
                      color: ride.acceptPets ? Colors.green : Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
