import 'package:carpro_app/providers/sos_category_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:carpro_app/models/sos_category.dart';
import 'package:flutter/material.dart';

class CategorySlide extends StatelessWidget {
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
            itemCount: sosCategoryProvider.getSosCategories.length,
            itemBuilder: (_, index) => categoryItem(
              context,
              index,
              sosCategoryProvider.getSosCategories.length,
              sosCategoryProvider.getSelectedCategoryId,
              sosCategoryProvider.getSosCategories[index],
            ),
          ),
        );
      },
    );
  }

  Widget categoryItem(BuildContext context, int index, int count,
      int selectedCategoryId, SosCategory sosCategory) {
    var imageUrl = sosCategory.image != null
        ? sosCategory.image
        : "https://www.softwarearge.com/wp-content/uploads/2018/09/no-image-icon-6.png";

    print("selectedCategoryId: $selectedCategoryId");

    return Container(
      width: 130,
      margin: EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 20.0,
          right: index == (count - 1) ? 20.0 : 0.0),
      child: Material(
        color: selectedCategoryId == sosCategory.id
            ? Colors.grey[300]
            : Colors.white,
        elevation: 6.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: () {
              context
                  .read<SosCategoryProvider>()
                  .findCategoryId(sosCategory.id);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 15.0,
                ),
                Image(
                  height: 18,
                  image: CachedNetworkImageProvider(imageUrl),
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 15.0),
                Flexible(
                  child: Text(
                    sosCategory.name,
                    style: TextStyle(
                      fontSize: 10,
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
