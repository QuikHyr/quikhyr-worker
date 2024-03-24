// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LocationModel {
  final num latitude;
  final num longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  });

  LocationModel copyWith({
    String? latitude,
    String? longitude,
  }) {
    return LocationModel(
      latitude: latitude as num,
      longitude: longitude as num,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: map['latitude'] as num,
      longitude: map['longitude'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocationModel(latitude: $latitude, longitude: $longitude)';

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}
