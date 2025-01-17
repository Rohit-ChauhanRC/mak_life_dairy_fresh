// import 'package:geolocator/geolocator.dart';
// import 'package:flutter/material.dart';

// class LocationService {
//   Future<Position?> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       debugPrint('Location services are disabled.');
//       return null;
//     }

//     // Check for location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         debugPrint('Location permissions are denied.');
//         return null;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       debugPrint(
//           'Location permissions are permanently denied. Cannot request permissions.');
//       return null;
//     }

//     // Get the current location
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       debugPrint(
//           'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
//       return position;
//     } catch (e) {
//       debugPrint('Error getting location: $e');
//       return null;
//     }
//   }
// }
