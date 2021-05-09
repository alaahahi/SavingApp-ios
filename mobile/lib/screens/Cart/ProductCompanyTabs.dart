import 'package:coupons/data/api.dart';
import 'package:coupons/models/CompanyModel.dart';
import 'package:coupons/screens/Cart/CompanyTabProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProductCompanyTabs extends StatelessWidget {
  ProductCompanyTabs({
    Key key,
    @required this.companyIds,
  }) : super(key: key);
  final List<int> companyIds;
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    final tabs = Provider.of<CompanyTabProvider>(context);
    Future.delayed(Duration(seconds: 0), () {
      if (tabs.nothingSelected) {
        tabs.select = companyIds.first;
      }
    });
    return Container(
      height: 50,
      width: double.infinity,
      child: FutureBuilder<List<CompanyModel>>(
        future: context.read<Api>().getCompaniesByIds(ids: companyIds),
        builder: (_, snapshot) => snapshot.hasData == false
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : ScrollablePositionedList.builder(
                padding: EdgeInsets.symmetric(horizontal: 60),
                scrollDirection: Axis.horizontal,
                itemScrollController: _scrollController,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    tabs.select = snapshot.data[index].id;
                    _scrollController.scrollTo(
                      index: index,
                      alignment: 0.2,
                      duration: Duration(milliseconds: 700),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        snapshot.data[index].title.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: tabs.isSelected(snapshot.data[index].id)
                          ? Colors.black
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
