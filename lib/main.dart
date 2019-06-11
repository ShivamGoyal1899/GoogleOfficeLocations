// Google Office Location App - #CodeWithFlutter
// Developed by Shivam Goyal (https://shivamgoyal.tk) for @Enappd
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
            //image: office.image,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Google Office Locations'),
        backgroundColor: Colors.white,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: const LatLng(20.5937, 78.9629),
          zoom: 4,
        ),
        markers: _markers.values.toSet(),
        mapType: MapType.normal,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        rotateGesturesEnabled: true,
        myLocationEnabled: true,
      ),
    ),
    theme: ThemeData(
      fontFamily: 'Raleway',
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.grey[600],
      ),
      // This colors the [InputOutlineBorder] when it is selected
      primaryColor: Colors.grey[500],
      textSelectionHandleColor: Colors.blue[500],
    ),
  );
}
