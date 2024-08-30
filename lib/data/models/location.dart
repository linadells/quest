import 'package:quest/domain/entities/location.dart';

class LocationModel extends LocationEntity{
  LocationModel({String? location}):super(location: location);

  Map<String, dynamic> toJson() {
    return {
      'location': location,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      location: json['location'],
    );
  }
}