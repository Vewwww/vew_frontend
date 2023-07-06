import 'package:vewww/model/location.dart';
import 'package:vewww/model/requests.dart';

class  WinchAcceptedRequestsResponse{
  List<WinchRequestData>? winchRequestData;

  WinchAcceptedRequestsResponse({this.winchRequestData});

  WinchAcceptedRequestsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      winchRequestData = <WinchRequestData>[];
      json['data'].forEach((v) {
        winchRequestData!.add(WinchRequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (winchRequestData != null) {
      data['data'] = winchRequestData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WinchRequestData {
  Location? location;
  String? sId;
  Driver? driver;
  Car? car;
  Winch? winch;
  String? createdAt;

  WinchRequestData(
      {this.location,
      this.sId,
      this.driver,
      this.car,
      this.winch,
      this.createdAt});

  WinchRequestData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    driver =
        json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    winch = json['winch'] != null ? Winch.fromJson(json['winch']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (car != null) {
      data['car'] = car!.toJson();
    }
    if (winch != null) {
      data['winch'] = winch!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}
