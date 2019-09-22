import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'MobileId';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }


  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }
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
            title: const Text('Safe Home'),
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
