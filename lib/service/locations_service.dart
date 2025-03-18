import 'package:your_project_name/model/ride/locations.dart';
import '../repository/location_repo.dart';

class LocationsService {
  static final LocationsService _instance = LocationsService._internal();
  LocationsRepository? _repository; //Store reference to the repository

  List<Location>? _availableLocations;

  LocationsService._internal();

  factory LocationsService() {
    return _instance;
  }

  void initialize(LocationsRepository repository) {
    _repository = repository;
    _availableLocations = null;
  }
  //Function use for initial the repository
  List<Location> getLocations() {
    _availableLocations ??= _repository!.getLocations(); // Get location using
    return _availableLocations!;
  }
}
