import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/api_constant.dart';
import '../../../../constants/colors.dart';

class OrderDetailsController extends GetxController {

 final Rx<LatLng> _pickUpPosition = LatLng(0.0, 0.0).obs;
 LatLng get pickUpPosition => _pickUpPosition.value;
 set pickUpPosition(LatLng pickupLatLng) => _pickUpPosition.value = pickupLatLng;

 final Rx<LatLng> _destinationPosition = LatLng(0.0, 0.0).obs;
 LatLng get destinationPosition => _destinationPosition.value;
 set destinationPosition(LatLng pickupLatLng) => _destinationPosition.value = pickupLatLng;

 final RxMap<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{}.obs;
 Map<PolylineId, Polyline> get polyLines => _polyLines.value;
 set polyLines(Map<PolylineId, Polyline> poly) => _polyLines.value = poly;

 final Completer<GoogleMapController> mapController = Completer();
 final Location locationService = Location();

 final RxBool _isPaymentDetailVisible = false.obs;
 bool get isPaymentDetailVisible => _isPaymentDetailVisible.value;
 set isPaymentDetailVisible(bool v) => _isPaymentDetailVisible.value = v;

 final RxBool _isOrderStatusVisible = false.obs;
 bool get isOrderStatusVisible => _isOrderStatusVisible.value;
 set isOrderStatusVisible(bool v) => _isOrderStatusVisible.value = v;
  
  @override
  void onInit() {
    super.onInit();
    pickUpPosition = LatLng(28.41297439277074, 77.04385013569278);
    destinationPosition = LatLng(28.45936391919057, 77.07289018135027);
    _getLocationUpdates();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pickUpPosition = LatLng(0.0, 0.0);
    destinationPosition = LatLng(0.0, 0.0);
  }

  /// Updates the camera to a new position on the map
  Future<void> updateCameraPosition(LatLng newPosition) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: newPosition,
      zoom: 12.0,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  /// Listen to location updates
  Future<void> _getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    print("feching Location");
    serviceEnabled = await locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationService.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    locationService.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        LatLng currentPosition = LatLng(locationData.latitude!, locationData.longitude!);
        // setState(() {
        //   _pickUpPosition = currentPosition;
        // });

        // Fetch polyline and directions
        _fetchDirectionsAndInstructions(pickUpPosition, destinationPosition);

      }
    });
  }

  /// Fetch directions and navigation instructions from Google Directions API
  Future<void> _fetchDirectionsAndInstructions(LatLng origin, LatLng destination) async {
    final String directionsUrl =
        'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${origin.latitude},${origin.longitude}&'
        'destination=${destination.latitude},${destination.longitude}&'
        'key=$googleMapApiKey';

    final response = await http.get(Uri.parse(directionsUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<LatLng> polylineCoordinates = [];

      if (data['routes'] != null && data['routes'].isNotEmpty) {
        final points = data['routes'][0]['overview_polyline']['points'];
        polylineCoordinates.addAll(_decodePolyline(points));
        
        _addPolyline(polylineCoordinates);
      }
    } else {
      print('Failed to fetch directions.');
    }
  }

  /// Decode polyline encoded string to list of LatLng
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polylinePoints = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polylinePoints.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polylinePoints;
  }

  /// Add polyline to the map
  void _addPolyline(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("polyline_id");
    Polyline polyline = Polyline(
      polylineId: id,
      visible: true,
      color: appGreen,
      points: polylineCoordinates,
      width: 5,
    );
    polyLines = {id:polyline};

  }

}
