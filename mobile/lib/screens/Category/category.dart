import 'package:coupons/data/api.dart';
import 'package:coupons/models/CategoriesModel.dart';
import 'package:coupons/widgets/Cards/InfoCard.dart';
import 'package:coupons/widgets/common/RemoteListNGridScaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key key, @required this.category}) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return RemoteListNGridScaffold(
      title: category.title,
      photo: category.photo,
      future: context.read<Api>().getCompanies(categoryId: category.id),
      filler: (item, shrink) => InfoCard(
        company: item,
        vertical: shrink,
      ),
    );
  }
}
