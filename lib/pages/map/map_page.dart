import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:url_launcher/url_launcher.dart';

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
  String _currentCategory = "Ангилал сонгох";
  Marker myMarker;
  // Circle circle;
  bool fuck = false;
  bool loading = true;
  List<Marker> marker1 = [], marker2 = [];

  CameraPosition initialLocation = CameraPosition(
    target: LatLng(47.9193279, 106.9178054),
    tilt: 0,
    zoom: 12.4,
  );

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
      // circle = Circle(
      //     circleId: CircleId("car"),
      //     radius: newLocalData.accuracy + 80,
      //     zIndex: 5,
      //     strokeColor: kColor1,
      //     center: latlng,
      //     fillColor: kColor1.withAlpha(70));
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

  // @override
  // void dispose() {
  //   if (_locationSubscription != null) {
  //     _locationSubscription.cancel();
  //   }
  //   super.dispose();
  // }

  // void _updatePosition(CameraPosition _position) {
  //   setState(() {
  //     marker = marker.copyWith(
  //       positionParam: LatLng(
  //         _position.target.latitude,
  //         _position.target.longitude,
  //       ),
  //     );
  //   });
  // }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    marker1 = [
      Marker(
        infoWindow: InfoWindow(
          title: "Vetnam засвар",
          snippet: "+97699113352",
          onTap: () {
            _launchURL("+97699113352");
          },
        ),
        markerId: MarkerId("Vetnam засвар"),
        position: LatLng(47.934469, 106.923324),
        icon: BitmapDescriptor.defaultMarkerWithHue(120),
      ),
      Marker(
        infoWindow: InfoWindow(
          title: "HongKong засвар",
          snippet: "дэлгэрэнгүй харах",
          onTap: () {
            slideDialog.showSlideDialog(
              context: context,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "HongKong засвар",
                    style: TextStyle(
                      color: kTextDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
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
                        Text(""),
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
                        Text(""),
                      ],
                    ),
                  ),
                  Text(
                    "",
                  ),
                  Text(
                    "+97699110713",
                    style: TextStyle(),
                  ),
                  Text(
                    "",
                  ),
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
          },
        ),
        markerId: MarkerId("HongKong засвар"),
        position: LatLng(47.932118, 106.915857),
        icon: BitmapDescriptor.defaultMarkerWithHue(120),
      ),
      Marker(
        infoWindow: InfoWindow(
          title: "Japan засвар",
          snippet: "+97699117013",
          onTap: () {
            _launchURL("+97699117013");
          },
        ),
        markerId: MarkerId("Japan засвар"),
        position: LatLng(47.920002, 106.901367),
        icon: BitmapDescriptor.defaultMarkerWithHue(120),
      ),
    ];
    marker2 = [
      Marker(
        infoWindow: InfoWindow(
          title: "BlueJungle зогсоол",
          snippet: "дэлгэрэнгүй харах",
          onTap: () {
            slideDialog.showSlideDialog(
              context: context,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "BlueJungle зогсоол",
                    style: TextStyle(
                      color: kTextDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Column(
                          children: [
                            Text(
                              "Ажилдаг өдөр",
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 12.0,
                              ),
                            ),
                            Text("2,4,6"),
                          ],
                        ),
                        Text(""),
                        Column(
                          children: [
                            Text(
                              "Нээх / Хаах",
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 12.0,
                              ),
                            ),
                            Text("08:30-20:30"),
                          ],
                        ),
                        Text(""),
                      ],
                    ),
                  ),
                  Text(
                    "",
                  ),
                  Text(
                    "+97699115372",
                    style: TextStyle(),
                  ),
                  Text(
                    "",
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: kPrimaryColor.withOpacity(1),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    onPressed: () {
                      _launchURL("+97699115372");
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
          },
        ),
        markerId: MarkerId("BlueJungle зогсоол"),
        position: LatLng(47.918995, 106.913958),
        icon: BitmapDescriptor.defaultMarkerWithHue(64),
      ),
      Marker(
        infoWindow: InfoWindow(
          title: "Skytwin зогсоол",
          snippet: "дэлгэрэнгүй харах",
          onTap: () {
            slideDialog.showSlideDialog(
              context: context,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Skytwin зогсоол",
                    style: TextStyle(
                      color: kTextDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Column(
                          children: [
                            Text(
                              "Ажилдаг өдөр",
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 12.0,
                              ),
                            ),
                            Text("1,3,5"),
                          ],
                        ),
                        Text(""),
                        Column(
                          children: [
                            Text(
                              "Нээх / Хаах",
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 12.0,
                              ),
                            ),
                            Text("06:30-18:30"),
                          ],
                        ),
                        Text(""),
                      ],
                    ),
                  ),
                  Text(
                    "",
                  ),
                  Text(
                    "+97699115332",
                    style: TextStyle(),
                  ),
                  Text(
                    "",
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: kPrimaryColor.withOpacity(1),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    onPressed: () {
                      _launchURL("+97699115332");
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
          },
        ),
        markerId: MarkerId("Skytwin зогсоол"),
        position: LatLng(47.920188, 106.882275),
        icon: BitmapDescriptor.defaultMarkerWithHue(64),
      ),
      Marker(
        infoWindow: InfoWindow(
          title: "BirdFlow зогсоол",
          snippet: "дэлгэрэнгүй харах",
          onTap: () {
            slideDialog.showSlideDialog(
              context: context,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "BirdFlow зогсоол",
                    style: TextStyle(
                      color: kTextDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Column(
                          children: [
                            Text(
                              "Ажилдаг өдөр",
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 12.0,
                              ),
                            ),
                            Text("1,2,3,4"),
                          ],
                        ),
                        Text(""),
                        Column(
                          children: [
                            Text(
                              "Нээх / Хаах",
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 12.0,
                              ),
                            ),
                            Text("07:30-19:30"),
                          ],
                        ),
                        Text(""),
                      ],
                    ),
                  ),
                  Text(
                    "",
                  ),
                  Text(
                    "+97699111377",
                    style: TextStyle(),
                  ),
                  Text(
                    "",
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: kPrimaryColor.withOpacity(1),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    onPressed: () {
                      _launchURL("+97699111377");
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
          },
        ),
        markerId: MarkerId("BirdFlow зогсоол"),
        position: LatLng(47.911283, 106.898148),
        icon: BitmapDescriptor.defaultMarkerWithHue(64),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackColor2,
        leading: Padding(
          padding: const EdgeInsets.all(
            6.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? Padding(
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
                      ),
                      child: CupertinoButton(
                        color: Colors.transparent,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                : Padding(
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
                    child: DropdownButton<String>(
                      value: _currentCategory,
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      onChanged: (String newValue) {
                        setState(() {
                          _currentCategory = newValue;
                        });
                        if (_currentCategory != "Ангилал сонгох")
                          _googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              new CameraPosition(
                                target: LatLng(47.9193279, 106.9178054),
                                tilt: 0,
                                zoom: 12.4,
                              ),
                            ),
                          );
                      },
                      items: <String>[
                        "Ангилал сонгох",
                        "Дугуй засвар",
                        "Төлбөртөй зогсоол",
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            width: 150.0,
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kTextDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
              if (_currentCategory == "Ангилал сонгох")
                Expanded(
                  child: GoogleMap(
                    // onCameraMove: ((_position) => _updatePosition(_position)),
                    initialCameraPosition: initialLocation,
                    markers: Set.of((myMarker != null) ? [myMarker] : []),
                    // circles: Set.of((circle != null) ? [circle] : []),
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController = controller;
                    },
                  ),
                ),
              if (_currentCategory == "Дугуй засвар")
                Expanded(
                  child: GoogleMap(
                    // onCameraMove: ((_position) => _updatePosition(_position)),
                    initialCameraPosition: initialLocation,
                    markers:
                        Set.of((myMarker != null) ? [myMarker] + marker1 : []),
                    // circles: Set.of((circle != null) ? [circle] : []),
                    onMapCreated: (GoogleMapController controller) {
                      _googleMapController = controller;
                    },
                  ),
                ),
              if (_currentCategory == "Төлбөртөй зогсоол")
                Expanded(
                  child: GoogleMap(
                    // onCameraMove: ((_position) => _updatePosition(_position)),
                    initialCameraPosition: initialLocation,
                    markers:
                        Set.of((myMarker != null) ? [myMarker] + marker2 : []),
                    // circles: Set.of((circle != null) ? [circle] : []),
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
}
