import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quikhyr_worker/common/bloc/worker_bloc.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/common/widgets/quik_short_button.dart';
import 'package:quikhyr_worker/models/location_model.dart';

class MapScreen extends StatefulWidget {
  final LocationModel locationModel;
  const MapScreen({super.key, required this.locationModel});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void checkPermissionStatus(context) async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Location Permission Required'),
            content: const Text(
                'This app requires access to your location to provide its services. Please grant location permission in your device settings.'),
            actions: [
              TextButton(
                child: const Text('Open Settings'),
                onPressed: () {
                  openAppSettings();
                },
              ),
            ],
          );
        },
      );
    }
  }

  final snackBar = SnackBar(
    backgroundColor: onSecondary, // Change the background color
    content: Column(
      children: [
        const Text('Please Enable Location Permission',
            style: workerListNameTextStyle),
        QuikSpacing.vS16(),
        QuikShortButton(
          width: 188,
          svgPath: QuikAssetConstants.settingsActiveSvg,
          text: 'Go To Settings',
          onPressed: () {
            openAppSettings();
          },
        )
      ],
    ),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24), // Add a border radius
    ),
    behavior: SnackBarBehavior.floating, // Make the SnackBar floating
    margin: const EdgeInsets.all(10), // Add some margin
    padding: const EdgeInsets.symmetric(
        horizontal: 24, vertical: 24), // Add some padding
  );

  void getLocationPermission(context) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        permission = await Geolocator.requestPermission();
        debugPrint('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permissions are permanently denied');
      } else {
        debugPrint('Location permissions are granted');
        animateToCurrentPosition();
        debugPrint("AnimatedCamera run");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

  late GoogleMapController mController;

  LatLng userLocation = const LatLng(0, 0);
  late CameraPosition camPos;

  CameraPosition newPos = const CameraPosition(
    target: LatLng(57.30997564343281, -67.97627907301552),
    zoom: 16.5,
  );

  Future<void> animateToCurrentPosition() async {
    try {
      // CameraPosition newPos = CameraPosition(target: LatLng(0,0),zoom: 15);
      CameraPosition newPos = await getCurrentLocation(context);
      await mController.animateCamera(CameraUpdate.newCameraPosition(newPos));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<CameraPosition> getCurrentLocation(context) async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled, throw an exception
        checkPermissionStatus(context);
      }

      // Check the location permission status
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Location permission is denied, request permission
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // Permission is still not granted, throw an exception
          throw Exception('Location permission not granted');
        }
      }

      // Get the current position
      final position = await Geolocator.getCurrentPosition();

      userLocation = LatLng(position.latitude, position.longitude);
      return CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.5,
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    camPos = CameraPosition(
      target: LatLng(widget.locationModel.latitude.toDouble(),
          widget.locationModel.longitude.toDouble()),
      zoom: 16.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: camPos,
            onMapCreated: (GoogleMapController controller) {
              mController = controller;
            },
            onCameraMove: (CameraPosition position) {
              userLocation = position.target;
              // setState(() {});
            },
          ),
          Center(
            child: SvgPicture.asset(
              QuikAssetConstants.locationFilledSvg,
              color: primary,
              height: 24,
              width: 24,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: QuikShortButton(
              width: 78,
              svgPath: QuikAssetConstants.currentLocationSvg,
              onPressed: () {
                getLocationPermission(context);
                // controller.checkPermissionStatus();

                // controller.update();
                // print(controller.userLocation.latitude);
              },
            ),
          ),
          Positioned(
            bottom: 80,
            left: 10,
            child: QuikShortButton(
                foregroundColor: onSecondary,
                backgroundColor: secondary,
                svgPath: QuikAssetConstants.locationFilledSvg,
                text: "Confirm",
                onPressed: () {
                  context.read<WorkerBloc>().add(UpdateLocation(LocationModel(
                      latitude: userLocation.latitude,
                      longitude: userLocation.longitude)));
                  context.pop();
                }
                // controller.checkPermissionStatus();

                // controller.update();
                // print(controller.userLocation.latitude);

                ),
          ),
        ],
      ),
    );
  }
}
