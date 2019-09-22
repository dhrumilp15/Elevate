// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return LatLng(
      latitude: (json['latitude'] as num)?.toDouble(),
      longitude: (json['longitude'] as num)?.toDouble());
}

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude
    };

Shelter _$ShelterFromJson(Map<String, dynamic> json) {
  return Shelter(
      freeformAddress: json['freeformAddress'] as String,
      latitude: (json['latitude'] as num)?.toDouble(),
      longitude: (json['longitude'] as num)?.toDouble(),
      name: json['name'] as String,
      capacity: (json['capacity'] as num)?.toDouble(),
      score: (json['score'] as num)?.toDouble(),
      occupancy: (json['occupancy'] as num)?.toDouble(),
      percentage: (json['percentage'] as num)?.toDouble());
}

Map<String, dynamic> _$ShelterToJson(Shelter instance) => <String, dynamic>{
      'freeformAddress': instance.freeformAddress,
      'score': instance.score,
      'occupancy': instance.occupancy,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'name': instance.name,
      'capacity': instance.capacity,
      'percentage': instance.percentage
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
      shelters: (json['shelters'] as List)
          ?.map((e) =>
              e == null ? null : Shelter.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LocationsToJson(Locations instance) =>
    <String, dynamic>{'shelters': instance.shelters};
