import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationCard extends StatelessWidget {
  final LatLng location;
  const LocationCard({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: location,
                  zoom: 18,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('m'),
                    position: location,
                  ),
                },
                compassEnabled: false,
                mapToolbarEnabled: false,
                myLocationButtonEnabled: false,
                liteModeEnabled: Platform.isAndroid,
                scrollGesturesEnabled: false,
                rotateGesturesEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                label: Text('Refine Location'),
                icon: Icon(Icons.edit_location_alt),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
