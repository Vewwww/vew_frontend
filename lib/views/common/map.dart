import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:vewww/bloc/loaction_cubit/loaction_cubit.dart';

class MapElement extends StatefulWidget {
  MapElement({required this.locationCubit, Key? key}) : super(key: key);
  LocationCubit locationCubit;
  @override
  State<MapElement> createState() => _MapElementState(locationCubit);
}

class _MapElementState extends State<MapElement> {
  _MapElementState(this.locationCubit);
  final Completer<GoogleMapController> _googleMapController = Completer();

  CameraPosition? _cameraPosition;
  LocationCubit locationCubit;
  late LatLng _defaultLatLng;

  late LatLng _draggedLatlng;

  String _draggedAddress = "";

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    //set default latlng for camera position
    _defaultLatLng = const LatLng(11, 104);
    _draggedLatlng = _defaultLatLng;

    _cameraPosition =
        CameraPosition(target: _defaultLatLng, zoom: 5 // number of map view
            );
    //map will redirect to my current location when loaded
    _gotoUserCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildMap(),
      //get a float button to click and go to current location
    );
  }

  Widget _buildMap() {
    return Stack(
      children: [
        _getMap(),
        _getCustomPin(),
        Positioned(
          bottom: 100,
          right: 10,
          child: GestureDetector(
            onTap: () {
              _gotoUserCurrentPosition();
            },
            child: const CircleAvatar(
              child: Icon(Icons.location_on),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getMap() {
    return GoogleMap(
      initialCameraPosition: _cameraPosition!,
      mapType: MapType.normal,
      onCameraIdle: () {
        //this function will trigger when user stop dragging on map
        //every time user drag and stop it will display address
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) async {
        //this function will trigger when user keep dragging on map
        //every time user drag this will get value of latlng
        _draggedLatlng = cameraPosition.target;
        await _getAddress(_draggedLatlng);
        locationCubit.changeLatLon(_draggedLatlng, _draggedAddress);
        locationCubit.latitude = _defaultLatLng.latitude;
        locationCubit.longitude = _defaultLatLng.longitude;
      },
      onMapCreated: (GoogleMapController controller) {
        //this function will trigger when map is fully loaded
        if (!_googleMapController.isCompleted) {
          //set controller to google map when it is fully loaded
          _googleMapController.complete(controller);
        }
      },
    );
  }

  Future _getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String addresStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    _draggedAddress = addresStr;
  }

  Widget _getCustomPin() {
    return Center(
      child: SizedBox(
        width: 150,
        child: Lottie.asset("assets/lottie/pin.json"),
      ),
    );
  }

  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    debugPrint("pos lat:${currentPosition.latitude}");
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      debugPrint("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        debugPrint("user denied location permission");
      }
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
      debugPrint("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }
}
