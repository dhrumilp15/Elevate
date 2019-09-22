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

Office _$OfficeFromJson(Map<String, dynamic> json) {
  return Office(
      address: json['address'] as String,
      lat: (json['lat'] as num)?.toDouble(),
      lng: (json['lng'] as num)?.toDouble(),
      name: json['name'] as String);
}

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
      offices: (json['offices'] as List)
          ?.map((e) =>
              e == null ? null : Office.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LocationsToJson(Locations instance) =>
    <String, dynamic>{'offices': instance.offices};
