import 'package:coupons/data/api.dart';
import 'package:coupons/models/CompanyModel.dart';
import 'package:coupons/models/ProductModel.dart';
import 'package:coupons/services/authService.dart';
import 'package:coupons/services/likes.dart';
import 'package:coupons/widgets/Cards/LikableCard.dart';
import 'package:coupons/widgets/Cards/LikeButton.dart';
import 'package:flutter/material.dart';
import 'package:coupons/widgets/common/RemoteListNGridScaffold.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({
    Key key,
    this.company,
    this.showEdit = false,
  }) : super(key: key);
  final CompanyModel company;
  final bool showEdit;

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return RemoteListNGridScaffold(
      title: widget.company.title,
      photo: widget.company.photo,
      logo: widget.company.logo,
      future: context.read<Api>().getProducts(comapnyId: widget.company.id),
      actions: widget.showEdit
          ? [
              CircleIconButton(
                icon: Icons.add,
                color: Colors.green,
                onPressed: () async {
                  bool res = await showModalBottomSheet(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) => AddProductModal(),
                  );

                  if (res == true) setState(() {});
                },
              ),
            ]
          : [
              LikeButton<CompanyLikeService>(id: widget.company.id),
              CircleIconButton(
                icon: Icons.pin_drop,
                color: Colors.blue,
                onPressed: () async {
                  final availableMaps = await MapLauncher.installedMaps;

                  await availableMaps.first.showMarker(
                    coords: widget.company.location,
                    title: widget.company.title,
                  );
                },
              ),
              CircleIconButton(
                icon: Icons.phone,
                color: Colors.green,
                onPressed: () => launch('tel:${widget.company.phone}'),
              ),
            ],
      filler: (ProductModel item, bool shrink) => LikableCard(
        product: item,
        vertical: shrink,
        showEdit: widget.showEdit,
      ),
    );
  }
}

class AddProductModal extends StatefulWidget {
  @override
  _AddProductModalState createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductModal> {
  bool isOffer = false;

  List<TextEditingController> ctrls = [];

  _AddProductModalState() {
    for (var i = 0; i < 10; i++) {
      ctrls.add(new TextEditingController());
    }
  }
  Widget textField(String hint, TextEditingController ctr) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: ctr,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Text('New Products'),
          Divider(),
          //
          Text('English'),
          textField('Title', ctrls[0]),
          textField('Description', ctrls[1]),
          //
          Divider(),
          Text('Arabic'),
          textField('Title', ctrls[2]),
          textField('Description', ctrls[3]),
          //
          Divider(),
          Text('Kurdish'),
          textField('Title', ctrls[4]),
          textField('Description', ctrls[5]),
          //
          Divider(),

          // textField('Photo URL', ctrls[6]),
          textField('Price', ctrls[7]),
          GestureDetector(
            onTap: () => setState(() => isOffer = !isOffer),
            child: Row(
              children: [
                Checkbox(
                  value: isOffer,
                  onChanged: (v) => setState(() => isOffer = !isOffer),
                ),
                Expanded(child: Text('Offer')),
              ],
            ),
          ),
          if (isOffer) textField('Offer Price', ctrls[8]),
          TextButton(
            child: Text('Save'),
            onPressed: () async {
              try {
                final user = await context.read<AuthService>().user;
                await context
                    .read<Api>()
                    .submitProduct(phone: user.phoneNumber, json: {
                  "photo": ctrls[9].text,
                  "price": ctrls[6].text,
                  "discount_price": ctrls[8].text,
                  "visiable": "0",
                  "discount_start_data": "",
                  "discount_end_data": "",
                  "data": [
                    {
                      "lang": "en",
                      "title": ctrls[0].text,
                      "desc": ctrls[1].text
                    },
                    {
                      "lang": "ar",
                      "title": ctrls[2].text,
                      "desc": ctrls[3].text
                    },
                    {
                      "lang": "kr",
                      "title": ctrls[4].text,
                      "desc": ctrls[5].text
                    },
                  ]
                });
                Navigator.pop(context, true);
              } catch (e) {
                Fluttertoast.showToast(msg: e.toString());
              }
            },
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
