import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpro_app/models/car.dart';
import 'package:carpro_app/providers/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarItem extends StatelessWidget {
  final int index;
  final Car car;

  const CarItem({
    Key key,
    this.index,
    this.car,
  }) : super(key: key);

  String moneyFormat(String price) {
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    } else {
      return "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      // constraints: BoxConstraints(
      //   minHeight: 250.0,
      // ),
      height: 250.0,
      child: Card(
        margin: EdgeInsets.only(
          top: 0,
          left: index % 2 == 1 ? 10 : 20,
          right: index % 2 == 1 ? 20 : 10,
          bottom: 20.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: Image(
                      image: CachedNetworkImageProvider(car.images[0]["url"]),
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "${car.name}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "MontserratSemiBold",
                        height: 1.0,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      maxLines: 2,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
                    child: Text(
                      "${moneyFormat(car.price.toString())}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF009245),
                        fontWeight: FontWeight.bold,
                        fontFamily: "MontserratBold",
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    context.read<CarProvider>().findId(car.id);
                    Navigator.pushNamed(context, "/car-detail");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
