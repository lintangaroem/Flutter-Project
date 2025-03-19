import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maps_app/data_dummy.dart';
import 'package:maps_app/map_type_google.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsV1Page extends StatefulWidget {
  const MapsV1Page({super.key});

  State<MapsV1Page> createState() => _MapsV1PageState();
}

class _MapsV1PageState extends State<MapsV1Page> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  double latitude = -7.2804494;
  double longitude = 112.7947228;

  var mapType = MapType.normal;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps V1"),
        actions: [
          PopupMenuButton(
            onSelected: onSelectedMapType,
              itemBuilder: (context) {
              return googleMapTypes.map(
                  (typeGoogle) {
                    return PopupMenuItem(
                      value: typeGoogle.type,
                      child: Text(typeGoogle.type.name)
                    );
                  },
              ).toList();
              },
          )
        ],
      ),
      body: Stack(
        children: [
          //google maps
          _buildGoogleMaps(),
        ],
      ),
    );
  }

  Widget _buildGoogleMaps(){
    return GoogleMap(
      mapType: mapType,
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: markers,
    );
  }

  void onSelectedMapType(Type value){
    setState(() {
      switch (value){
        case Type.Normal:
          mapType = MapType.normal;
          break;
        case Type.Hybrid:
          mapType = MapType.hybrid;
          break;
        case Type.Terrain:
          mapType = MapType.terrain;
          break;
        case Type.Satellite:
          mapType = MapType.satellite;
          break;
        default:
      }
    });
  }
}