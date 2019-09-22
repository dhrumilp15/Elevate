import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _colour(double percentage) {
    if (percentage <= 50.0)
        return BitmapDescriptor.hueGreen;
    else if (percentage <= 75.0)
      return BitmapDescriptor.hueYellow;
    else if (percentage <= 100.0){
      return BitmapDescriptor.hueOrange;
    }
    else {
      return BitmapDescriptor.hueRed;
    }
  }
  final Map<String, Marker> _markers = {};

  _getmarkers(String postalcode) async
  {
    final shelters = await locations.getGoogleOffices(postalcode);
    setState(() {
      _markers.clear();
      for (final shelter in shelters.shelters) {
        final marker = Marker(
          markerId: MarkerId(shelter.name),
          position: LatLng(shelter.latitude, shelter.longitude),
          infoWindow: InfoWindow(
              title: shelter.name,
              snippet: shelter.postalCode
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(_colour(shelter.percentage)),
          onTap: () {
            _getmarkers(shelter.postalCode);
          },
        );
        _markers[shelter.name] = marker;
      }
    });

  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
//    final googleOffices = await locations.getGoogleOffices("");
    _getmarkers("M1E 2M6");
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Google Office Locations'),
            backgroundColor: Colors.green[700],
          ),
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(43.6484763, -79.3825738),
              zoom: 11.5,
            ),
            markers: _markers.values.toSet(),
          ),
        ),
      );
}
