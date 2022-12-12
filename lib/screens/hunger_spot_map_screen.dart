// ignore_for_file: prefer_const_constructors, unused_import, import_of_legacy_library_into_null_safe, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, depend_on_referenced_packages, avoid_print

import 'package:feedie/screens/hunger_spot_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HungerSpotMap extends StatefulWidget {
  const HungerSpotMap({super.key});
  static const routeName = '/hunger-spot-map';

  @override
  State<HungerSpotMap> createState() => _HungerSpotMapState();
}

class _HungerSpotMapState extends State<HungerSpotMap> {
  double long = 49.5;
  double lat = -0.09;
  static LatLng? point;
  var isLoading = false;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();

    setState(() {
      point = LatLng(position.latitude, position.longitude);
    });
    List<Placemark> placeMark =
        await placemarkFromCoordinates(point!.latitude, point!.longitude);
    String? name = placeMark[0].name;
    String? subLocality = placeMark[0].subLocality;
    String? locality = placeMark[0].locality;
    String? administrativeArea = placeMark[0].administrativeArea;
    String? postalCode = placeMark[0].postalCode;
    String? country = placeMark[0].country;
    address =
        "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    isLoading = true;
    _determinePosition().then(
      (value) {
        setState(() {
          isLoading = false;
        });
      },
    );
    super.initState();
  }

  MapController mapController = MapController();
  String? address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hunger Spot')),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 450,
                      height: 600,
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                      child: FlutterMap(
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: point!,
                                builder: (ctx) => Container(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.orange,
                                    size: 50,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                        mapController: mapController,
                        options: MapOptions(
                          onTap: (tapPosition, p) async {
                            setState(() {
                              point = p;
                              print(point);
                            });
                            List<Placemark> placeMark =
                                await placemarkFromCoordinates(
                                    p.latitude, p.longitude);
                            String? name = placeMark[0].name;
                            String? subLocality = placeMark[0].subLocality;
                            String? locality = placeMark[0].locality;
                            String? administrativeArea =
                                placeMark[0].administrativeArea;
                            String? postalCode = placeMark[0].postalCode;
                            String? country = placeMark[0].country;
                            address =
                                "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
                            print(address);
                          },
                          center: point,
                          zoom: 17.0,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  HungerSpotForm.routeName,
                                  arguments: address);
                            },
                            icon: Icon(Icons.location_searching_rounded),
                            label: Text('Add this spot!')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  HungerSpotForm.routeName,
                                  arguments: "");
                            },
                            child: Text('Enter Manually'))
                      ],
                    )
                  ],
                ),
              ));
  }
}
