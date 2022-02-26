import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class LocationHelper {
  double? latitude;
  double? longitude;

  Future<void> getLocation() async {
    Location _location = Location();
    LocationData _locationStatus;
    PermissionStatus _permissionStatus;
    bool _serviceStatus; 

    _serviceStatus = await _location.serviceEnabled();
    if (!_serviceStatus) {
      _serviceStatus = await _location.requestService();
      if (!_serviceStatus) {
        return;
      }
    }

    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    _locationStatus = await _location.getLocation();
    latitude = _locationStatus.latitude;
    longitude = _locationStatus.longitude;
  }
}
