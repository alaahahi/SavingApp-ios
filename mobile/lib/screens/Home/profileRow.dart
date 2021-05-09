import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupons/data/api.dart';
import 'package:coupons/models/AdminCompany.dart';
import 'package:coupons/screens/Company/company.dart';
import 'package:coupons/services/authService.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coupons/screens/Home/weather.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:coupons/services/activation.dart';

class ProfileRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // pushNewScreen(
                  //   context,
                  //   withNavBar: false,
                  //   screen: LoginScreen2(),
                  // );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: CachedNetworkImageProvider(
                        'https://3znvnpy5ek52a26m01me9p1t-wpengine.netdna-ssl.com/wp-content/uploads/2017/07/noimage_person.png',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome'.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          FutureBuilder<User>(
                            future: context.read<AuthService>().user,
                            builder: (_, snapshot) =>
                                UserPhoneNumber(user: snapshot.data),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              WeatherIcon(),
            ],
          ),
          AdminCompanies(),
          UserCoins(),
        ],
      ),
    );
  }
}

class AdminCompanies extends StatefulWidget {
  const AdminCompanies({Key key}) : super(key: key);

  @override
  _AdminCompaniesState createState() => _AdminCompaniesState();
}

class _AdminCompaniesState extends State<AdminCompanies> {
  @override
  void initState() {
    super.initState();
    fetch();
  }

  List<AdminCompanyModel> companies = [];

  Future<void> fetch() async {
    final user = await context.read<AuthService>().user;
    if (user == null || user.phoneNumber == null) {
      return;
    }
    final _companies =
        await context.read<Api>().getUserCompany(phone: user.phoneNumber);
    setState(() => companies = _companies);
  }

  @override
  Widget build(BuildContext context) {
    if (companies == null || companies.isEmpty) {
      return Container();
    }

    return Column(
      children: companies
          .map(
            (x) => GestureDetector(
              onTap: () {
                pushNewScreen(
                  context,
                  // withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                  screen: CompanyPage(
                    company: x.toComapnyModel(),
                    showEdit: true,
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(
                      Icons.settings,
                      color: Colors.white.withOpacity(0.7),
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manage Products For'.tr(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          x.title,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class UserCoins extends StatefulWidget {
  const UserCoins({Key key, this.phoneNumber}) : super(key: key);

  final String phoneNumber;

  @override
  _UserCoinsState createState() => _UserCoinsState();
}

class _UserCoinsState extends State<UserCoins> {
  @override
  void initState() {
    super.initState();
    fetch();
  }

  bool _loading = false;
  bool _error = false;
  int _points = 0;

  Future<void> fetch() async {
    setState(() {
      _loading = true;
      _error = false;
    });
    try {
      final user = await context.read<AuthService>().user;
      final points =
          await context.read<Api>().userPoints(phone: user.phoneNumber);
      setState(() {
        _loading = false;
        _error = false;
        _points = points;
      });
    } catch (ex) {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fetch,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.purple,
          boxShadow: [
            BoxShadow(
                color: Colors.purple.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(0, 10)),
          ],
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Your Coins'.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            _loading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : _error
                    ? Icon(
                        Icons.autorenew,
                        color: Colors.white,
                        size: 40,
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          _points.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 31,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

class UserPhoneNumber extends StatelessWidget {
  const UserPhoneNumber({Key key, this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    if (user == null || user.phoneNumber == null) {
      return renderLoader();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user?.phoneNumber ?? 'No phone number'.tr(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Consumer<Activation>(
          builder: (_, value, __) => value.isActive == ActivationState.unknown
              ? renderLoader()
              : Text(
                  value.isActive == ActivationState.active
                      ? 'Activated until'.tr() + ' ${value.until}'
                      : 'Not active'.tr(),
                  style: TextStyle(
                    color: value.isActive == ActivationState.active
                        ? Colors.green
                        : Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );
  }

  CircularProgressIndicator renderLoader() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.black,
      ),
    );
  }
}
