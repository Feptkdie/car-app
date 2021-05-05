import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpro_app/models/company.dart';
import 'package:carpro_app/models/company_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:carpro_app/providers/company_category_provider.dart';

import '../../constants.dart';

class MapPage extends StatefulWidget {
  static String routeName = "/map";

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _googleMapController;
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker myMarker;

  CameraPosition initialLocation = CameraPosition(
    target: LatLng(47.9193279, 106.9178054),
    tilt: 0,
    zoom: 12.4,
  );

  int _selectedCategoryId;
  CompanyCategory _currentCompanyCategory;
  List<CompanyCategory> _companyCategories = [];
  List<Marker> _currentMarkers = [];

  void _launchURL(_url) async => await canLaunch('tel:$_url')
      ? await launch('tel:$_url')
      : throw 'Could not launch $_url';

  void updateMarkerAndCircle(LocationData newLocalData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      myMarker = Marker(
        markerId: MarkerId("home"),
        position: latlng,
        draggable: false,
        zIndex: 2,
        flat: true,
        icon: BitmapDescriptor.defaultMarker,
      );
    });
  }

  void getCurrentLocation() async {
    try {
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_googleMapController != null) {
          _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              new CameraPosition(
                target: LatLng(newLocalData.latitude, newLocalData.longitude),
                tilt: 0,
                zoom: 14.00,
              ),
            ),
          );
          updateMarkerAndCircle(newLocalData);
          _locationSubscription.cancel();
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _companyCategories =
        context.read<CompanyCategoryProvider>().getCompanyCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: kBackColor2,
        leading: Padding(
          padding: const EdgeInsets.all(
            6.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.01,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.height * 0.045,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.red[500],
                      Colors.red[900],
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius: 7,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Map",
          style: TextStyle(
            color: kTextGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Row(
            children: [
              Icon(
                Icons.location_pin,
                color: kTextGrey,
              ),
              Container(
                width: 200.0,
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<int>(
                      hint: Text("Ангилал сонгох"),
                      value: _selectedCategoryId,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      items:
                          _companyCategories.map<DropdownMenuItem<int>>((map) {
                        return DropdownMenuItem<int>(
                          value: map.id,
                          child: Container(
                            width: 150.0,
                            child: Text(
                              map.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kTextDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (int value) {
                        print("onChanged: $value");
                        setState(() {
                          _currentMarkers = [];
                          _selectedCategoryId = value;
                          _currentCompanyCategory = _companyCategories
                              .firstWhere((category) => category.id == value,
                                  orElse: () => null);

                          if (_currentCompanyCategory != null) {
                            _currentCompanyCategory.companies.forEach(
                              (Company company) {
                                _currentMarkers.add(
                                  Marker(
                                    infoWindow: InfoWindow(
                                      title: company.name,
                                      snippet: "дэлгэрэнгүй харах",
                                      onTap: () {
                                        showSlideDialogInfo(context, company);
                                      },
                                    ),
                                    markerId: MarkerId(company.name),
                                    position: LatLng(
                                      double.parse(company.coordX),
                                      double.parse(company.coordY),
                                    ),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        120),
                                  ),
                                );
                              },
                            );

                            var moveToPosition =
                                LatLng(47.9193279, 106.9178054);
                            if (_currentMarkers.length > 0) {
                              moveToPosition = _currentMarkers[0].position;
                            }

                            _googleMapController.animateCamera(
                              CameraUpdate.newCameraPosition(
                                new CameraPosition(
                                  target: moveToPosition,
                                  tilt: 0,
                                  zoom: 12.4,
                                ),
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.location_searching),
        onPressed: () {
          getCurrentLocation();
        },
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                kBackColor1,
                kBackColor2,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              if (_currentCompanyCategory == null)
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: initialLocation,
                    markers: Set.of((myMarker != null) ? [myMarker] : []),
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController = controller;
                    },
                  ),
                ),
              if (_currentCompanyCategory != null)
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: initialLocation,
                    markers: Set.from(_currentMarkers),
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController = controller;
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showSlideDialogInfo(BuildContext context, Company company) {
    slideDialog.showSlideDialog(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            company.name,
            style: TextStyle(
              color: kTextDark,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          if (company.logo != null)
            Image(
              image: CachedNetworkImageProvider(company.logo),
            ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Column(
                  children: [
                    Text(
                      "Ажилдаг өдөр",
                      style: TextStyle(
                        color: kTextGrey,
                        fontSize: 12.0,
                      ),
                    ),
                    Text("1,2,3,4,6"),
                  ],
                ),
                SizedBox(),
                Column(
                  children: [
                    Text(
                      "Нээх / Хаах",
                      style: TextStyle(
                        color: kTextGrey,
                        fontSize: 12.0,
                      ),
                    ),
                    Text("09:30-19:30"),
                  ],
                ),
                SizedBox(),
              ],
            ),
          ),
          SizedBox(),
          Text(
            "+97699110713",
            style: TextStyle(),
          ),
          SizedBox(),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: kPrimaryColor.withOpacity(1),
            padding: EdgeInsets.only(left: 5, right: 5),
            onPressed: () {
              _launchURL("+97699110713");
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Залгах".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
