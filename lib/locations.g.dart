// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return LatLng(
      lat: (json['lat'] as num)?.toDouble(),
      lng: (json['lng'] as num)?.toDouble());
}

Map<String, dynamic> _$LatLngToJson(LatLng instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

Shelter _$ShelterFromJson(Map<String, dynamic> json) {
  return Shelter(
      address: json['address'] as String,
      lat: (json['lat'] as num)?.toDouble(),
      lng: (json['lng'] as num)?.toDouble(),
      name: json['name'] as String,
      capacity: (json['capacity'] as num)?.toDouble(),
      score: (json['score'] as num)?.toDouble());
}

Map<String, dynamic> _$ShelterToJson(Shelter instance) => <String, dynamic>{
      'address': instance.address,
      'capacity': instance.capacity,
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'score': instance.score
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
