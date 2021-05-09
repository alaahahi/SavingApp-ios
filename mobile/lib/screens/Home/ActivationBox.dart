import 'package:coupons/data/api.dart';
import 'package:coupons/models/ActivationResult.dart';
import 'package:coupons/screens/Home/ActivationInput.dart';
import 'package:coupons/services/activation.dart';
import 'package:coupons/services/authService.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivationBox extends StatefulWidget {
  ActivationBox({Key key}) : super(key: key);

  @override
  _ActivationBoxState createState() => _ActivationBoxState();
}

class _ActivationBoxState extends State<ActivationBox> {
  @override
  void initState() {
    super.initState();

    context
        .read<AuthService>()
        .user
        .then((u) => u.phoneNumber)
        .then((phone) async {
      final ActivationResult res =
          await context.read<Api>().checkActivation(phone: phone);
      context.read<Activation>().setActivation(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Activation>(
      builder: (_, state, __) => state.isActive == ActivationState.unknown
          ? Center(child: CircularProgressIndicator())
          : state.isActive == ActivationState.active
              ? Container()
              : Column(
                  children: [
                    renderStrips(),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.red.shade200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Not Active'.tr(),
                            style: TextStyle(
                              color: Colors.red.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            'You have not activate your account yet.'.tr() +
                                '\n' +
                                'Please activate your account for the full experiance'
                                    .tr(),
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                          SizedBox(height: 20),
                          ActivationInput(),
                        ],
                      ),
                    ),
                    renderStrips(),
                  ],
                ),
    );
  }

  Widget renderStrips() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment(-.1, .7),
          stops: [0.0, 0.5, 0.5, 1],
          colors: [
            Colors.red.shade200,
            Colors.red.shade200,
            Colors.red.shade300,
            Colors.red.shade300,
          ],
          tileMode: TileMode.repeated,
        ),
      ),
    );
  }
}
