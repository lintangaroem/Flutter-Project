import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maps_app/map_type_google.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsV2Page extends StatefulWidget{
  const MapsV2Page({super.key});

  State<MapsV2Page> createState() => _MapsV2PageState();
}

class _MapsV2PageState extends State<MapsV2Page>{
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  double latitude = -7.2804494;
  double longitude = 112.7947228;

  var mapType = MapType.normal;

  Position? devicePosition;
  String address = "";

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps V2"),
        actions: [
          PopupMenuButton(
            onSelected: onSelectedMapType,
            itemBuilder: (context){
              return googleMapTypes.map(
                  (typeGoogle){
                    return PopupMenuItem(
                      value: typeGoogle.type,
                      child: Text(typeGoogle.type.name)
                    );
                  }
              ).toList();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          _buildGoogleMaps(),
          _buildSearchCard(),
        ],
      ),
    );
  }

  void initState(){
    super.initState();
    Geolocator.requestPermission();
  }

  Widget _buildGoogleMaps(){
    return GoogleMap(
      mapType: mapType,
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller){
        _controller.complete(controller);
      },
      myLocationEnabled: true,
    );
  }

  void onSelectedMapType(Type value){
    setState(() {
      switch(value){
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

  _buildSearchCard(){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              devicePosition != null ? Text(
                "Lokasi saat ini: ${devicePosition?.latitude} ${devicePosition?.longitude}"
              )
                  :const Text("Lokasi belum terdeteksi")
            ],
          ),
        ),
      ),
    );
  }
}