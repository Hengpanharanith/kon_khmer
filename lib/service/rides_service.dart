import 'package:your_project_name/model/ride_pref/ride_pref.dart';
import 'package:your_project_name/repository/ride_repository.dart';


import '../model/ride/ride.dart';

// Ride sort types for bonus
enum RideSortType {
  departureTime,
  price,
}

class RidesFilter {
  final bool petAccepted;
  
  RidesFilter({this.petAccepted = false});
}

class RidesService {
  static final RidesService _instance = RidesService._internal();
  RidesRepository? _repository;
  
  // Private constructor
  RidesService._internal();
  
  // Singleton accessor
  factory RidesService() {
    return _instance;
  }
  
  // Initialize with repository
  void initialize(RidesRepository repository) {
    _repository = repository;
  }
  

  List<Ride> getRides(RidePref preference, RidesFilter? filter, {RideSortType? sortType}) {
    if (_repository == null) {
      throw Exception('RidesService not initialized with repository');
    }
    
    List<Ride> rides = _repository!.getRides(preference, filter);
    
    // Apply sorting if requested (bonus)
    if (sortType != null) {
      switch (sortType) {
        case RideSortType.departureTime:
          rides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
          break;
        case RideSortType.price:
          rides.sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
          break;
      }
    }
    
    return rides;
  }
}