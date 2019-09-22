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
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final shelter in googleOffices.shelters) {
        final marker = Marker(
          markerId: MarkerId(shelter.name),
          position: LatLng(shelter.latitude, shelter.longitude),
          infoWindow: InfoWindow(
            title: shelter.name,
            snippet: shelter.freeformAddress
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(_colour(shelter.percentage)),
          onTap: () {
            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Not in stock'),
                  content: const Text('This item is no longer available'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
        _markers[shelter.name] = marker;
      }
    });
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
