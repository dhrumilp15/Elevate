import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'locations.g.dart';


@JsonSerializable()
class LatLng {
  LatLng({
    this.lat,
    this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

//@JsonSerializable()
//class Region {
//  Region({
//    this.coords,
//    this.id,
//    this.name,
//    this.zoom,
//  });
//
//  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
//  Map<String, dynamic> toJson() => _$RegionToJson(this);
//
//  final LatLng coords;
//  final String id;
//  final String name;
//  final double zoom;
//}

@JsonSerializable()
class Shelter {
  Shelter({
    this.address,
    this.lat,
    this.lng,
    this.name,
    this.capacity,
    this.score,
  });
  factory Shelter.fromJson(Map<String, dynamic> json) => _$ShelterFromJson(json);
  Map<String, dynamic> toJson() => _$ShelterToJson(this);

  final String address;
  final double capacity;
  final double lat;
  final double lng;
  final String name;
  final double score;
}

@JsonSerializable()
class Locations {
  Locations({
    this.shelters,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Shelter> shelters;
}

//MAIN CALLS THIS
Future<Locations> getShelters() async {
  var now = DateTime.now();
  var formatter = DateFormat('MM');
  String month = formatter.format(now);
  double lat = 43.6484763;
  double long = -79.3825738;

  var googleLocationsURL = 'https://specter:8080/shelter/analyse?lat=${lat}&lon=${long}&month=${month}';

  // Retrieve the locations of Google offices
  final response = await http.get(googleLocationsURL);
  if (response.statusCode == 200) {
//    print("RIGHT HERE: " + response.body);
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
            ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}