import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vendor_app/functions/google_map_handler.dart';
import 'package:vendor_app/models/vendor_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vendor_app/screen/vendor_dialog.dart';
import 'package:vendor_app/screen/widgets/app_bar.dart';
import 'package:vendor_app/screen/widgets/location_input_box.dart';

class VendorsScreen extends StatefulWidget {
  final List<Vendor> vendorsList;
  VendorsScreen({required this.vendorsList, Key? key}) : super(key: key);

  @override
  _VendorsScreenState createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> with WidgetsBindingObserver {
  late GoogleMapController mapController;
  late BitmapDescriptor customIcon;
  late String _mapStyle;

  final Map<String, Marker> _markers = {};
  final TextEditingController yourLocationTextController = TextEditingController();
  final TextEditingController cartLocationTextController = TextEditingController();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      print("APP RESUMED");
      try {
        await mapController.setMapStyle(_mapStyle);
      } catch (e) {
        print("ERROR: ${e.toString()}");
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    GoogleMapHandler.getMapStyleFromFile('assets/files/map_style.txt').then((styleString) => _mapStyle = styleString);
    GoogleMapHandler.getMarkerIconFromAssetPng('assets/images/shop.png', 100).then((markerIcon) => customIcon = markerIcon);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50, left: 10, right: 10, top: 70),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: const LatLng(28.7041, 77.1025),
                      ),
                      markers: _markers.values.toSet(),
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: CustomAppBar(onMenuBtnClicked: onMenuBtnClicked, onShopNowBtnClicked: onShopNowBtnClicked),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 40, right: 40),
                  child: CustomLocationInputBox(yourLocationTextController: yourLocationTextController, cartLocationTextController: cartLocationTextController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        mapController = controller;
      });
      try {
        await controller.setMapStyle(_mapStyle);
      } catch (e) {
        print("ERROR: ${e.toString()}");
      }
      _markers.clear();
      List<LatLng> latlngList = [];
      for (final vendor in this.widget.vendorsList) {
        final marker = Marker(
          markerId: MarkerId(vendor.vendorId),
          position: LatLng(vendor.vendorLatitude, vendor.vendorLongitute),
          icon: customIcon,
          onTap: () => onMarkerIconClicked(vendor),
        );
        _markers[vendor.vendorId] = marker;
        latlngList.add(LatLng(vendor.vendorLatitude, vendor.vendorLongitute));
      }
      if (latlngList.length == 1) {
        controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(target: latlngList.first, zoom: 12)));
      } else {
        try {
          LatLngBounds bounds = GoogleMapHandler.boundsFromLatLngList(latlngList);
          CameraUpdate u2 = CameraUpdate.newLatLngBounds(
            bounds,
            50,
          );
          controller.animateCamera(u2).then((void v) {
            GoogleMapHandler.check(u2, controller);
          });
        } catch (e) {
          print("ERROR: ${e.toString()} ");
        }
      }
    });
  }

  void onMarkerIconClicked(Vendor vendor) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialogBox(name: vendor.vendorName, totalStock: vendor.vendorTotalStockValue, img: vendor.vendorImageUrl);
      },
    );
  }

  void onMenuBtnClicked() {
    print("Menu btn is clicked !!");
  }

  void onShopNowBtnClicked() {
    print("Shop btn is clicked !!");
  }
}
