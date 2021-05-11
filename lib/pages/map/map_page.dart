import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpro_app/models/company.dart';
import 'package:carpro_app/models/company_category.dart';
import 'package:flushbar/flushbar.dart';
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

  double toRadius(double x) {
    return x * pi / 180;
  }

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
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.0,
              ),
              child: Container(
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
          "Байршил",
          style: TextStyle(
            color: kTextGrey,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        actions: [
          Row(
            children: [
              Icon(
                Icons.location_pin,
                color: kTextGrey,
              ),
              SizedBox(width: 5.0),
              Container(
                width: 150.0,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    hint: Text("Ангилал сонгох"),
                    value: _selectedCategoryId,
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    items: _companyCategories.map<DropdownMenuItem<int>>((map) {
                      return DropdownMenuItem<int>(
                        value: map.id,
                        child: Text(
                          map.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kTextDark,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      );
                    }).toList(),
                    onChanged: (int value) {
                      print("onChanged: $value");
                      setState(() {
                        _currentMarkers = [];
                        _selectedCategoryId = value;
                        _currentCompanyCategory = _companyCategories.firstWhere(
                            (category) => category.id == value,
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
                                    120,
                                  ),
                                ),
                              );
                            },
                          );

                          var moveToPosition = LatLng(47.9193279, 106.9178054);
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
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 12.0,
          ),
          Container(
            height: 38.0,
            child: FloatingActionButton.extended(
              heroTag: null,
              backgroundColor: kPrimaryColor,
              onPressed: () {
                int r = 6378137; // Earth’s mean radius in meter
                double dLat = toRadius(_currentMarkers[1].position.latitude -
                    myMarker.position.latitude);
                double dLong = toRadius(_currentMarkers[1].position.longitude -
                    myMarker.position.longitude);
                double a = sin(dLat / 2) * sin(dLat / 2) +
                    cos(toRadius(myMarker.position.latitude)) *
                        cos(toRadius(_currentMarkers[1].position.latitude)) *
                        sin(dLong / 2) *
                        sin(dLong / 2);
                double c = 2 * atan2(sqrt(a), sqrt(1 - a));
                double d = r * c;
                int meterDistance = d.toInt();
                _showAlertLoginFlash(meterDistance.toString() + " meter");
              },
              icon: Icon(Icons.near_me),
              label: Text("Ойрхон"),
            ),
          ),
          SizedBox(
            width: 12.0,
          ),
          Container(
            height: 38.0,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.location_searching),
              onPressed: () {
                getCurrentLocation();
              },
            ),
          ),
        ],
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
                    markers: Set.of((myMarker != null)
                        ? [myMarker] + _currentMarkers
                        : _currentMarkers),
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
      child: Expanded(
        child: Column(
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (company.logo != null)
                      CachedNetworkImage(
                        imageUrl: company.logo,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(strokeWidth: 2.0),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    if (!["", " ", null, false, 0].contains(company.jsonData))
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: json.decode(company.jsonData).length,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 36,
                            padding: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 10.0),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 120.0,
                                      child: Text(
                                        json.decode(company.jsonData)[index]
                                            ["label"],
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color:
                                              Colors.black87.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20.0),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          json.decode(company.jsonData)[index]
                                              ["value"],
                                          style: TextStyle(fontSize: 13.0),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                if (index <
                                    json.decode(company.jsonData).length - 1)
                                  Divider(),
                              ],
                            ),
                          );
                        },
                      ),
                    SizedBox(height: 20.0),
                    if (!["", " ", null, false, 0].contains(company.phone))
                      Text("Утас: ${company.phone}"),
                    if (!["", " ", null, false, 0].contains(company.phone))
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: kPrimaryColor.withOpacity(1),
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        onPressed: () {
                          _launchURL("${company.phone}");
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              size: 18.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5.0),
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
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertLoginFlash(String message) {
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      message: message,
      duration: Duration(seconds: 4),
      icon: Icon(
        Icons.near_me,
        size: 28.0,
        color: Colors.blue[300],
      ),
    )..show(context);
  }
}
