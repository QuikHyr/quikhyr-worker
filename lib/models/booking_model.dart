
import '../common/enums/status.dart';
import 'location_model.dart';

class BookingData {
  List<Booking> currentBookings;
  List<Booking> pastBookings;

  BookingData({
    required this.currentBookings,
    required this.pastBookings,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    if (json["currentBookings"] is! List || json["pastBookings"] is! List) {
      throw 'Invalid data format';
    }

    return BookingData(
      currentBookings: (json["currentBookings"] as List)
          .map((x) => Booking.fromJson(x))
          .toList(),
      pastBookings: (json["pastBookings"] as List)
          .map((x) => Booking.fromJson(x))
          .toList(),
    );
  }

//   factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
//   currentBookings: (json["currentBookings"] as List).map((x) => Booking.fromJson(x)).toList(),
//   pastBookings: (json["pastBookings"] as List).map((x) => Booking.fromJson(x)).toList(),
// );

//   Map<String, dynamic> toJson() => {
//         "currentBookings":
//             List<dynamic>.from(currentBookings.map((x) => x.toJson())),
//         "pastBookings": List<dynamic>.from(pastBookings.map((x) => x.toJson())),
//       };
// }

// "locationName": "Nizhnesaitovo",
// "dateTime": "16/04/2024 12:42:00",
// "ratePerUnit": 258,
// "unit": "hh",
// "status": "Pending"
}

class Booking {
  String? id;
  String serviceName;
  String? clientId;
  String? clientName;
  bool? hasRated;
  LocationModel? location;
  String serviceAvatar;
  String? subserviceId;
  String subserviceName;
  String workerName;
  String? workerId;
  DateTime dateTime;
  String unit;
  String locationName;
  num ratePerUnit;
  Status status;

  Booking({
    this.clientName,
    this.hasRated,
    this.id,
    required this.serviceName,
    this.clientId,
    this.location,
    required this.serviceAvatar,
    this.subserviceId,
    required this.subserviceName,
    required this.workerName,
    this.workerId,
    required this.dateTime,
    required this.unit,
    required this.locationName,
    required this.ratePerUnit,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    // DateTime dateTime;
    // if (json['dateTime'] is String) {
    //   var match = RegExp(r'Timestamp\(seconds=(\d+), nanoseconds=(\d+)\)')
    //       .firstMatch(json['dateTime']);
    //   if (match != null) {
    //     var seconds = int.parse(match.group(1)!);
    //     var nanoseconds = int.parse(match.group(2)!);
    //     dateTime = DateTime.fromMillisecondsSinceEpoch(
    //         seconds * 1000 + nanoseconds ~/ 1000000);
    //   } else {
    //     throw 'Invalid dateTime format';
    //   }
    // } else if (json['dateTime'] is Map) {
    //   dateTime = DateTime.fromMillisecondsSinceEpoch(
    //       (json['dateTime']['_seconds'] as int) * 1000 +
    //           (json['dateTime']['_nanoseconds'] as int) ~/ 1000000);
    // } else {
    //   throw 'Invalid dateTime format';
    // }

    return Booking(
      clientName: json["clientName"] ?? '',
      hasRated: json["hasRated"] ?? false,
      id: json["id"] ?? '',
      serviceName: json["serviceName"] ?? '',
      clientId: json["clientId"] ?? '',
      location: LocationModel.fromMap(
          json["location"] ?? {'latitude': 66, 'longitude': 66}),
      serviceAvatar: json["serviceAvatar"] ?? '',
      subserviceName: json["subserviceName"] ?? '',
      workerName: json["workerName"] ?? '',
      dateTime: DateTime.parse(json["dateTime"]),
      unit: json["unit"] ?? '',
      locationName: json["locationName"] ?? '',
      ratePerUnit: json["ratePerUnit"] ?? 0,
      status: Status.fromJson(json["status"] ?? 'Pending'),
    );
  }

  Map<String, dynamic> toJson() => {
        "hasRated": hasRated,
        "serviceName": serviceName,
        "clientId": clientId ?? '-99',
        "location": location?.toJson(),
        "serviceAvatar": serviceAvatar,
        "subserviceId": subserviceId ?? '-100',
        "subserviceName": subserviceName,
        "workerName": workerName,
        "workerId": workerId ?? '-200',
        "dateTime": dateTime.toIso8601String(),
        "unit": unit,
        "locationName": locationName,
        "ratePerUnit": ratePerUnit,
        "status": status.toJson(),
      };
}

class Timestamps {
  CreatedAt createdAt;
  CreatedAt updatedAt;

  Timestamps({
    required this.createdAt,
    required this.updatedAt,
  });

  factory Timestamps.fromJson(Map<String, dynamic> json) => Timestamps(
        createdAt: CreatedAt.fromJson(json["createdAt"]),
        updatedAt: CreatedAt.fromJson(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toJson(),
        "updatedAt": updatedAt.toJson(),
      };

  factory Timestamps.fromMap(Map<String, dynamic> map) {
    return Timestamps(
      createdAt: CreatedAt.fromMap(map['createdAt']),
      updatedAt: CreatedAt.fromMap(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt.toMap(),
      'updatedAt': updatedAt.toMap(),
    };
  }
}

class CreatedAt {
  int seconds;
  int nanoseconds;

  CreatedAt({
    required this.seconds,
    required this.nanoseconds,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
        seconds: json["_seconds"],
        nanoseconds: json["_nanoseconds"],
      );

  Map<String, dynamic> toJson() => {
        "_seconds": seconds,
        "_nanoseconds": nanoseconds,
      };
  factory CreatedAt.fromMap(Map<String, dynamic> map) {
    return CreatedAt(
      seconds: map['_seconds'],
      nanoseconds: map['_nanoseconds'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_seconds': seconds,
      '_nanoseconds': nanoseconds,
    };
  }

  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(
        seconds * 1000 + nanoseconds ~/ 1000000);
  }

  static CreatedAt fromDateTime(DateTime dateTime) {
    int seconds = dateTime.millisecondsSinceEpoch ~/ 1000;
    int nanoseconds = (dateTime.millisecondsSinceEpoch % 1000) * 1000000;
    return CreatedAt(seconds: seconds, nanoseconds: nanoseconds);
  }
}
