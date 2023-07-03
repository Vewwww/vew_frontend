import 'package:vewww/model/requests.dart';

class  WinchAcceptedRequestsResponse{
  List<WinchRequestData>? winchRequestData;

  WinchAcceptedRequestsResponse({this.winchRequestData});

  WinchAcceptedRequestsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      winchRequestData = <WinchRequestData>[];
      json['data'].forEach((v) {
        winchRequestData!.add(new WinchRequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.winchRequestData != null) {
      data['data'] = this.winchRequestData!.map((v) => v.toJson()).toList();
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
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    winch = json['winch'] != null ? new Winch.fromJson(json['winch']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    if (this.winch != null) {
      data['winch'] = this.winch!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}
