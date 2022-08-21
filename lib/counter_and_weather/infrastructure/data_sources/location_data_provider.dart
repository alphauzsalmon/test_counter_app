import 'package:location/location.dart';

class LocationDataProvider {

Future<LocationData?> getLocation() async {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
  }

  _permissionGranted = await location.hasPermission();
  //print("1 _permissionGranted: $_permissionGranted");
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
  }
  if (_permissionGranted == PermissionStatus.deniedForever) {
    return null;
  }

  return await location.getLocation();
}
}