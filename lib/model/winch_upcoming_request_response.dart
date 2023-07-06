import 'package:vewww/model/winch_accepted_requests_response.dart';

class WinchUpcomingRequestResponse {
  bool? newRequests;
  List<WinchRequestData>? data;

  WinchUpcomingRequestResponse({this.newRequests, this.data});

  WinchUpcomingRequestResponse.fromJson(Map<String, dynamic> json) {
    newRequests = json['newRequests'];
    if (json['data'] != null) {
      data = <WinchRequestData>[];
      json['data'].forEach((v) {
        data!.add(WinchRequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newRequests'] = newRequests;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

