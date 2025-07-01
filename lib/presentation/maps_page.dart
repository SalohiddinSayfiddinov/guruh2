import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('First map'),
        ),
        body: Column(
          children: [
            const Text(
              'Select your place',
              style: TextStyle(fontSize: 24.0),
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.red,
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(12.0),
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                border: Border.all(color: Colors.grey),
              ),
              child: const GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(41.302171877549014, 69.26708368034794),
                  zoom: 15.0,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.red,
            ),
          ],
        ));
  }
}
