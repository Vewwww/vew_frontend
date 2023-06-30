import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

part 'loaction_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LoactionInitial());
  static LocationCubit get(context) => BlocProvider.of(context);

  bool isLoading = false;
  List<Placemark>? placemark;
  loc.LocationData? locationData;
  late double latitude;
  late double longitude;
  // this where data from map saved
  double? lat;
  double? long;
  String address = "";
  //---------------------------

  Future<void> getPermission() async {
    if (await Permission.location.isGranted) {
      await getLocation();
      if (locationData != null) {
        latitude = locationData!.latitude!;
        longitude = locationData!.longitude!;
      }
    } else {
      Permission.location.request();
    }
  }

  Future<void> getLocation() async {
    isLoading = true;
    // emit(LoadingState())
    locationData = await loc.Location.instance.getLocation();
    isLoading = false;
    // emit(DoneLoadingState())
  }

  void getAddress() async {
    isLoading = true;
    emit(LoadingState());
    if (locationData != null) {
      placemark = await placemarkFromCoordinates(
          locationData!.latitude!, locationData!.longitude!);
    }
    isLoading = false;
    emit(DoneLoadingState());
  }

  void changeLatLon(LatLng latLng, String address) {
    lat = latLng.latitude;
    long = latLng.longitude;
    this.address = address;
    emit(LocationChangedState());
  }
}
