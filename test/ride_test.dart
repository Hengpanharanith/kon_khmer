import 'package:flutter_test/flutter_test.dart';
import 'package:your_project_name/model/ride/locations.dart';
import 'package:your_project_name/model/ride_pref/ride_pref.dart';
import 'package:your_project_name/repository/mock/mock_ride_repo.dart';
import 'package:your_project_name/service/rides_service.dart';


void main() {
  late RidesService ridesService;

  setUp(() {
    ridesService = RidesService();
    ridesService.initialize(MockRidesRepository());
  });

  group('RidesService Tests', () {
    test('all', () {
      final preference = RidePref(
        departure: Location(name: 'Battambang', country: Country.cambodia),
        arrival: Location(name: 'Siem Reap', country: Country.cambodia),
        departureDate: DateTime.now(),
        requestedSeats: 1,
      );

      final rides = ridesService.getRides(preference, null);

      expect(rides.length, equals(4));

      print(
          'For your preference (Battambang -> Siem Reap, today 1 passenger) we found ${rides.length} rides:');
      for (final ride in rides) {
        final hour = ride.departureDate.hour;
        final minute = ride.departureDate.minute;
        final formattedTime =
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
        final amPm = hour < 12 ? 'am' : 'pm';
        print(
            '- at $formattedTime $amPm with ${ride.driver.firstName} (${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours)');
      }
    });

    test('pet', () {
      final preference = RidePref(
        departure: Location(name: 'Battambang', country: Country.cambodia),
        arrival: Location(name: 'Siem Reap', country: Country.cambodia),
        departureDate: DateTime.now(),
        requestedSeats: 1,
      );

      final filter = RidesFilter(petAccepted: true);

      final rides = ridesService.getRides(preference, filter);

      expect(rides.length, equals(1));
      expect(rides[0].driver.firstName, equals('Limhao'));

      print(
          '\nFor your preference (Battambang -> Siem Reap, today 1 passenger) with pets allowed:');
      print('Found ${rides.length} ride:');
      for (final ride in rides) {
        final hour = ride.departureDate.hour;
        final minute = ride.departureDate.minute;
        final formattedTime =
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
        final amPm = hour < 12 ? 'am' : 'pm';
        print(
            '- at $formattedTime $amPm with ${ride.driver.firstName} (${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours)');
      }
    });
  });
}
