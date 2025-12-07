import 'package:appnote/model/category_model.dart';
import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  const CardCategory(
      {super.key,
      required this.onTap,
      required this.onLongPress,
      required this.categoryModel});
  final void Function()? onTap;
  final void Function()? onLongPress;
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Image.asset(
              "images/folder.png",
              width: 140,
            ),
            Text(
              categoryModel.categoryName!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
