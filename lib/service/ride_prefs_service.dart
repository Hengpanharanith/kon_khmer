import '../dummy_data/dummy_data.dart';
import '../model/ride_pref/ride_pref.dart';

/// Abstract listener for ride preferences changes
abstract class RidePrefListener {
  void onRidePrefChanged(RidePreference? preference);
}

class RidePrefService {
  // Singleton implementation
  static final RidePrefService _instance = RidePrefService._internal();

  // Private fields
  final List<RidePrefListener> _listeners = [];
  List<RidePreference> _ridePrefsHistory = fakeRidePrefs;
  RidePreference? _currentRidePref;

  // Private constructor
  RidePrefService._internal();

  // Singleton accessor
  factory RidePrefService() {
    return _instance;
  }

  // Getters
  List<RidePreference> get ridePrefsHistory => _ridePrefsHistory;
  RidePreference? get currentRidePref => _currentRidePref;
  bool get hasCurrentRidePref => _currentRidePref != null;

  // Listener management
  void addListener(RidePrefListener listener) {
    _listeners.add(listener);
  }

  void removeListener(RidePrefListener listener) {
    _listeners.remove(listener);
  }

  // Update current preference
  void setCurrentPreference(RidePreference preference) {
    _currentRidePref = preference;
    _notifyListeners();

    // Add to history if not already present
    if (!_ridePrefsHistory.contains(preference)) {
      _ridePrefsHistory.insert(0, preference);
    }
  }

  // Private notify method
  void _notifyListeners() {
    for (var listener in _listeners) {
      listener.onRidePrefChanged(_currentRidePref);
    }
  }
}
