import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

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

@JsonSerializable()
class Office {
  Office({
    this.address,
    this.id,
    this.image,
    this.lat,
    this.lng,
    this.name,
    this.phone,
    this.region,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}

@JsonSerializable()
class Locations {
  Locations({
    this.offices,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Office> offices;
}

Future<Locations> getGoogleOffices() async {

  const googleLocationsURL = 'https://about.google/static/data/locations.json';

  // Retrieve the locations of Google offices
  final response = await http.get(googleLocationsURL);
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
            ' ${response.reasonPhrase}',
        uri: Uri.parse(googleLocationsURL));
  }
}

//import 'dart:convert';
//import 'dart:core';
//import 'dart:io';
//import 'package:http/http.dart' as http;
//import 'package:json_annotation/json_annotation.dart';
//import 'package:intl/intl.dart';
//
//part 'locations.g.dart';
//
//
//@JsonSerializable()
//class LatLng {
//  LatLng({
//    this.latitude,
//    this.longitude,
//  });
//
//  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
//  Map<String, dynamic> toJson() => _$LatLngToJson(this);
//
//  final double latitude;
//  final double longitude;
//}
//@JsonSerializable()
//class Shelter {
//  Shelter({
//    this.freeformAddress,
//    this.latitude,
//    this.longitude,
//    this.name,
//    this.capacity,
//    this.score,
//  });
//  factory Shelter.fromJson(Map<String, dynamic> json) => _$ShelterFromJson(json);
//  Map<String, dynamic> toJson() => _$ShelterToJson(this);
//
//  final String freeformAddress;
//  final double capacity;
//  final double latitude;
//  final double longitude;
//  final String name;
//  final double score;
//}
//
//@JsonSerializable()
//class Locations {
//  Locations({
//    this.shelters,
//  });
//
//  factory Locations.fromJson(Map<String, dynamic> json) =>
//      _$LocationsFromJson(json);
//  Map<String, dynamic> toJson() => _$LocationsToJson(this);
//
//  final List<Shelter> shelters;
//}
//
////MAIN CALLS THIS
//Future<Locations> getShelters() async {
//  var now = DateTime.now();
//  var formatter = DateFormat('MM');
//  String month = formatter.format(now);
//  double lat = 43.6484763;
//  double long = -79.3825738;
//
//  var googleLocationsURL = 'https://specter:8080/shelter/analyse?lat=${lat}&lon=${long}&month=${month}';
//  var biggus = '[{"capacity": 420, "freeformAddress": "dickus", "latitude": 43.6484763, "longitude": -79.3825738, "name": "Tonyc caboose", "score": 69}]';
//
//  print("biggus: " + biggus);
//  print(json.decode(biggus));
//
//  final response = await http.get(googleLocationsURL);
//  if (response.statusCode == 200) {
//    stderr.writeln(biggus);
//    stderr.writeln(json.decode(biggus));
//    return Locations.fromJson(json.decode(response.body));
//  } else {
//    throw HttpException(
//        'Unexpected status code ${response.statusCode}:'
//            ' ${response.reasonPhrase}',
//        uri: Uri.parse(googleLocationsURL));
//  }
//}