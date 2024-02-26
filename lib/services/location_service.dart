import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        return Future.error('Location services are disabled.');
      }

      // check location permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          return Future.error('Location permissions are denied retry later...');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      return Future.error("error occured while fetching location $e");
    }
  }
}
