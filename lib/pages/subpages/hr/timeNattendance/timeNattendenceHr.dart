import 'dart:developer'as dev;

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
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
  int tag=0;
  List<String> options=['site','showroom','factory'];
  List<double> latitudelists=[26.258694,26.258725,26.215939];//site showroom factory's latitudes
  List<double> longitudelists=[50.646000,50.645848,50.655116];//site showroom factory's longitudes

 /* List<double> latitudelists=[12.906285,12.913958,12.879077];//site showroom factory's latitudes
  List<double> longitudelists=[74.828268,74.847951,74.853015];//site showroom factory's longitudes*/

  List<String> premisisidlists=["PSID1","PSID2","PSID3"];//site showroom factory's premisisids;

  late GoogleMapController _controller;
  late Position _position;
  late Marker currentlocationmarker;
  late Marker destinationlocationmarker;

 double _destinationLatitude=26.258694;
 double _destinationLongitude=50.646000;

   late Position _destinationposition ;

  int distancetolocation = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getcurrentlocation();
  }

  @override
  Widget build(BuildContext context) {
    _destinationposition = Position(
        longitude:  _destinationLongitude, //bahrein location final
        //longitude: 74.853216, // sample location kadri
        timestamp: DateTime.now(),
        latitude: _destinationLatitude, //bahrein location final
        //latitude: 12.878930, //sample location kadri
        speed: 0.0,
        speedAccuracy: 0.0,
        accuracy: 20.0,
        altitude: 2,
        heading: 0.0);

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
        title: const Text("Attendance"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           ChipsChoice<int>.single(value: tag, onChanged: (val){
             setState(() {
               tag=val;
               _destinationLatitude=latitudelists[val];
               _destinationLongitude=longitudelists[val];
             });
           }, choiceItems: C2Choice.listFrom<int,String>(source: options, value: (i,v)=>i, label: (i,v)=>v,),
           wrapped: true,
             choiceActiveStyle: const C2ChoiceStyle(color : Colors.white,
                 labelStyle: TextStyle(fontWeight: FontWeight.bold),
                 borderRadius: BorderRadius.all(Radius.circular(14)),
             borderColor:Colors.red,
               backgroundColor: Colors.red,
             ),
             choiceStyle: const C2ChoiceStyle(
                 color: Colors.grey,
               labelStyle: TextStyle(fontWeight: FontWeight.bold),
                 borderRadius: BorderRadius.all(Radius.circular(14)),
               borderColor: Colors.black12,
               ),),
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
                    if(distancetolocation!=0)
                    {
                      Get.snackbar("Proximity", "Please go inside the location to punch.",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red.shade600,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(10),
                          duration: const Duration(seconds: 2));
                      return;
                    }
                    MyApi.postPunchedTime(name: 'MANZOOR', badgenumber: '103011',premisisid: premisisidlists[tag],
                        contractorid: '1', shiftid: '1', checktype: false);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(0, 40)),
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 12)),
                      backgroundColor: MaterialStateProperty.all(Colors.red.shade800)),
                  child: const Text("punch In"),
                ),

                ElevatedButton(
                  onPressed: () {
                    if(distancetolocation!=0)
                      {
                        Get.snackbar("Proximity", "Please go inside the location to punch.",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red.shade600,
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(10),
                            duration: const Duration(seconds: 2));
                        return;
                      }
                    MyApi.postPunchedTime(name: 'MANZOOR', badgenumber: '103011',premisisid: premisisidlists[tag],
                        contractorid: '1', shiftid: '1', checktype: true);
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


      _controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(_position.latitude, _position.longitude), zoomlevel));

    });
  }

  Set<Marker> _createMarker() {
    return <Marker>{
      currentlocationmarker,
      destinationlocationmarker,
    };
  }


  double getZoomLevel(double radius) {
    double scale = radius / 175;
    return ((16 - log(scale) / log(2)));
  }
  
  
}
