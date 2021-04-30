import 'package:carpro_app/providers/sos_category_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CategorySlide extends StatelessWidget {
  final List<Map<String, dynamic>> groups = [
    {"id": "1", "name": "Toyoto"},
    {"id": "2", "name": "Audi"},
    {"id": "3", "name": "Suzuki"},
    {"id": "4", "name": "Nissan"},
    {"id": "5", "name": "Mercedes Benz"},
    {"id": "6", "name": "Ford"},
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<SosCategoryProvider>(
      builder: (context, sosCategoryProvider, child) {
        return Container(
          margin:
              EdgeInsets.only(top: 20.0, left: 0.0, right: 0.0, bottom: 20.0),
          height: 54.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: groups.length,
            itemBuilder: (_, index) => categoryItem(
              context,
              index,
              groups.length,
              0,
              groups[index],
            ),
          ),
        );
      },
    );
  }

  Widget categoryItem(BuildContext context, int index, int count,
      int selectedCategoryId, dynamic category) {
    print("selectedCategoryId: $selectedCategoryId");

    return Container(
      width: 100,
      margin: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 20.0,
          right: index == (count - 1) ? 20.0 : 0.0),
      child: Material(
        color: selectedCategoryId == index ? Colors.grey[300] : Colors.white,
        elevation: 4.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: () {
              print("onTapped!");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Image(
                //   height: 18,
                //   image: CachedNetworkImageProvider(imageUrl),
                //   fit: BoxFit.cover,
                // ),
                SizedBox(width: 15.0),
                Flexible(
                  child: Text(
                    category["name"],
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "MontserratSemiBold",
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
