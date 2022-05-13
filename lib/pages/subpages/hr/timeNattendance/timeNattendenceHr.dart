import 'dart:developer'as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

import 'package:oryx_prj1/services/apiservice.dart';

class TimeNattendenceHr extends StatefulWidget {
  const TimeNattendenceHr({Key? key}) : super(key: key);

  @override
  State<TimeNattendenceHr> createState() => _TimeNattendenceHrState();
}

class _TimeNattendenceHrState extends State<TimeNattendenceHr> {
  late GoogleMapController _controller;
  late Position _position;
  late Marker currentlocationmarker;
  late Marker destinationlocationmarker;


  final Position _destinationposition = Position(

      //longitude:  50.646000, bahrein location final
      longitude: 74.853216,
      timestamp: DateTime.now(),
      //latitude: 26.258694, bahrein location final
      latitude: 12.878930,
      speed: 0.0,
      speedAccuracy: 0.0,
      accuracy: 20.0,
      altitude: 2,
      heading: 0.0);

  int distancetolocation = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getcurrentlocation();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loading) {
      currentlocationmarker = Marker(
        markerId: const MarkerId("1"),
        position: LatLng(_position.latitude, _position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: "Current location"),
      );

      destinationlocationmarker = Marker(
        markerId: const MarkerId("0"),
        position: LatLng(
            _destinationposition.latitude, _destinationposition.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: "destination location"),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Get My Location"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator(semanticsValue: "Loading..",))
                :  GoogleMap(
              initialCameraPosition: CameraPosition(
                  target:
                  LatLng(_position.latitude, _position.longitude)),
              mapType: MapType.hybrid,
              markers: _createMarker(),
              // polylines: _showpolyline?Set<Polyline>.of(polylines.values):const {},
              myLocationEnabled: true,
              onMapCreated: _onMapCreated,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  distancetolocation < 1000
                      ? "$distancetolocation meters away"
                      : "${(distancetolocation / 1000).toStringAsFixed(2)} Km away",
                  style: const TextStyle(color: Colors.black45),
                ),
                ElevatedButton(
                  onPressed: () {
                    MyApi.postPunchedTime(name: 'MANZOOR', badgenumber: '103011', checktime: '13-05-2022',
                        ctime: '17:28:12', contractorid: '1', shiftid: '1', checktype: false);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(0, 40)),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 12)),
                      backgroundColor: MaterialStateProperty.all(Colors.red.shade800)),
                  child: const Text("punch In"),
                ),

                ElevatedButton(
                  onPressed: () {
                    MyApi.postPunchedTime(name: 'MANZOOR', badgenumber: '103011', checktime: '13-05-2022',
                        ctime: '17:38:12', contractorid: '1', shiftid: '1', checktype: true);
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(0, 40)),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 12)),
                      backgroundColor: MaterialStateProperty.all(Colors.blue.shade800)),
                  child: const Text("punch Out"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getcurrentlocation() async {
    dev.log("step1");
    if (!await Geolocator.isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
      //sleep(const Duration(seconds: 1));
      await Future.delayed(const Duration(seconds: 4));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Using device location service..")));
    }

    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){

        Get.snackbar("Permission", "please accept permissions\n"
            "to use the app",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade300,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2));

      }
    }
    if(permission==LocationPermission.deniedForever){

      Get.snackbar("Permission denied", "we cannot request permission\nplease change permissions in mobile settings",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
    }

    _position = await Geolocator.getCurrentPosition(
        timeLimit: const Duration(seconds: 8));

    if (_position.isMocked) {

      Get.snackbar("Mock location", "mock location detected!\nplease turn off mock location.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
      return;
    }

    setState(() {
      _loading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;

    Geolocator.getPositionStream().listen((changedposition) {
      // make two markers in middle of camera view of map
      double distancebtwTwopoints = Geolocator.distanceBetween(
          _position.latitude,
          _position.longitude,
          _destinationposition.latitude,
          _destinationposition.longitude);


      setState(() {
        _position = changedposition;
        if(distancebtwTwopoints<70){
          distancetolocation=0;
        }else {
          distancetolocation = (distancebtwTwopoints.toInt());
        }
      });

      double circleRad = (distancebtwTwopoints / 2); //divide by 2 to get radius
      double zoomlevel = getZoomLevel(circleRad);

      print("\n\n\n $zoomlevel  ${_position.latitude} ${_position.longitude}");
      //14.30056098673837  12.8790826 74.8531424

      _controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(_position.latitude, _position.longitude), zoomlevel));

    });
  }

  Set<Marker> _createMarker() {
    return <Marker>{
      /* Marker(markerId: const MarkerId("1"),
          position:  LatLng(_position.latitude, _position.longitude),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(title: "Current location"),),*/
      currentlocationmarker,
      destinationlocationmarker,
    };
  }


  double getZoomLevel(double radius) {
    double scale = radius / 175;
    return ((16 - log(scale) / log(2)));
  }
  
  
}
