import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/data/api.dart';
import 'package:coupons/models/CategoriesModel.dart';
import 'package:coupons/screens/Category/category.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class RandomCategoryList extends StatelessWidget {
  const RandomCategoryList({Key key, this.isGrid = false}) : super(key: key);
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<Api>().getCategories(),
      builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.red),
              ),
            ],
          );
        }
        if (snapshot.hasData) {
          return isGrid
              ? GridView.count(
                  childAspectRatio: 300 / 340,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: renderChildren(context, snapshot.data),
                )
              : Container(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    children: renderChildren(context, snapshot.data),
                  ),
                );
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  List<Widget> renderChildren(BuildContext context, List<CategoryModel> data) {
    return data
        .map(
          (category) => CategoryButton(
            textName: category.title,
            imgItem: category.logo,
            onClick: () => pushNewScreen(
              context,
              screen: CategoryPage(category: category),
            ),
          ),
        )
        .toList();
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key key,
    this.textName,
    this.imgItem,
    this.onClick,
  }) : super(key: key);

  final String textName;
  final String imgItem;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Container(
            height: 80,
            margin: EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: imgItem,
              fit: BoxFit.cover,
            ),
          ),
          Text(textName),
        ],
      ),
    );
  }
}
