import 'package:vewww/model/requests.dart';
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
        data!.add(new WinchRequestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newRequests'] = this.newRequests;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

