import 'package:coupons/data/api.dart';
import 'package:coupons/screens/Auth/loginScreen.dart';
import 'package:coupons/screens/Home/ActivationInput.dart';
import 'package:coupons/services/activation.dart';
import 'package:coupons/widgets/Layouts/StyledAppBar.dart';
import 'package:coupons/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:coupons/widgets/common/LangaugeDropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:coupons/models/UserInfoModel.dart';

String number = " ";

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyledAppBar(title: 'Settings'.tr()),
      body: SettingsScreen(),
    );
  }
}

class Section extends StatelessWidget {
  const Section({Key key, this.title, this.tiles}) : super(key: key);

  final String title;
  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 40, 26, 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        ...tiles,
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  bool _isEditingText = false;

  bool _isEnableText = false;
  TextEditingController _editingController = TextEditingController();

  String initialText = "";
  String newValue;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Section(
          title: 'Account'.tr(),
          tiles: [
            Card(
              child: ListTile(
                title: Text('Phone'.tr()),
                leading: Icon(Icons.email),
                trailing: Consumer<AuthService>(
                  builder: (context, value, child) => FutureBuilder<User>(
                    future: value.user,
                    builder: (context, snapshot) => !snapshot.hasData
                        ? CircularProgressIndicator()
                        : Text(
                            number = snapshot.data.phoneNumber,
                            textDirection: ui.TextDirection.ltr,
                          ),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Container(child: Text('Name')),
                leading: Container(child: Icon(Icons.account_circle)),
                trailing: FutureBuilder<UserInfoModel>(
                  future: context.read<Api>().getUserInfo(Number: number),
                  builder: (context, snapshot) => !snapshot.hasData
                      ? CircularProgressIndicator()
                      : (snapshot.data.name != null)
                          ? _editTitleTextField(
                              snapshot.data.name, snapshot.data.phone)
                          : Text("Null"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: InkWell(
                onTap: () {
                  editName();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, top: 5),
                  child: Text(
                    "Edite",
                    textAlign: ui.TextAlign.right,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Consumer<Activation>(
                builder: (context, value, child) => ListTile(
                  leading: Icon(Icons.money),
                  title: Text('Activation'.tr()),
                  subtitle: value.isActive == ActivationState.active
                      ? Text('Active until'.tr() + ' ' + value.until,
                          style: TextStyle(color: Colors.green))
                      : value.isActive == ActivationState.notActive
                          ? Text('Your account is not active'.tr(),
                              style: TextStyle(color: Colors.red))
                          : Text('Loading . . .'.tr()),
                  trailing: value.isActive == ActivationState.active
                      ? Icon(Icons.check, color: Colors.green)
                      : value.isActive == ActivationState.notActive
                          ? Icon(Icons.error, color: Colors.orange, size: 35)
                          : CircularProgressIndicator(),
                ),
              ),
            ),
            ActivationListTile(),
            Card(
              child: ListTile(
                title: Text('Sign out'.tr()),
                leading: Icon(Icons.exit_to_app),
                onTap: () => context.read<AuthService>().signOut(),
              ),
            ),
          ],
        ),

        Section(
          title: 'Application Language'.tr(),
          tiles: [
            Card(
              child: ListTile(
                leading: Icon(Icons.translate),
                title: Text('Language'.tr()),
                trailing: LangaugeDropdown(
                  value: EasyLocalization.of(context).locale.languageCode,
                  onChange: (value) {
                    EasyLocalization.of(context).setLocale(Locale(value));
                  },
                ),
              ),
            ),
          ],
        ),

        Section(
          title: 'Contactus'.tr(),
          tiles: [
            Card(
              child: ListTile(
                title: Text(
                  'www.savingapp.com'.tr(),
                  style: TextStyle(color: Colors.blue),
                ),
                leading: Icon(
                  Icons.language,
                  color: Colors.blue,
                ),
                onTap: () {
                  savingappURL();
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  '0096407501000951'.tr(),
                ),
                leading: Icon(Icons.call),
                onTap: () {
                  Toool();
                },
              ),
            ),
          ],
        ),

        Section(
          title: 'Power By'.tr(),
          tiles: [
            Card(
              child: ListTile(
                title: Text(
                  'Intellij App'.tr(),
                  style: TextStyle(color: Colors.blue),
                ),
                leading: Icon(
                  Icons.language,
                  color: Colors.blue,
                ),
                onTap: () {
                  intellijappURL();
                },
              ),
            ),
          ],
        ),

        /////////////////////////

        // Section(
        //   title: 'Security'.tr(),
        //   tiles: [
        //     ListTile(
        //       title: Text('Enable Notifications'.tr()),
        //       leading: Icon(Icons.phonelink_lock),
        //       trailing: Switch(
        //         value: lockInBackground,
        //         onChanged: (bool value) {
        //           setState(() {
        //             lockInBackground = value;
        //             notificationsEnabled = value;
        //           });
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        // Section(
        //   title: 'Misc'.tr(),
        //   tiles: [
        //     ListTile(
        //       title: Text('Terms of Service'.tr()),
        //       leading: Icon(Icons.description),
        //       onTap: () {},
        //     ),
        //     ListTile(
        //       title: Text('Open source licenses'.tr()),
        //       leading: Icon(Icons.collections_bookmark),
        //       onTap: () {},
        //     ),
        //     ListTile(
        //       title: Text('Version: 2.4.0 (287)'),
        //       leading: Icon(Icons.collections_bookmark),
        //       onTap: () {},
        //     )
        //   ],
        // ),
        SizedBox(height: 160),
      ],
    );
  }

  void savingappURL() async {
    const url = 'https://www.savingapp.co/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void intellijappURL() async {
    const url = 'https://intellijapp.github.io/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void Toool() async {
    const url = 'tel://+96407501000951';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _editTitleTextField(String inputText, String phone) {
    initialText = inputText;
    if (_isEditingText)
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Container(
            child: TextField(
              textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                enabled: _isEnableText,
                hintText: "New Name",
              ),
              textAlign: TextAlign.right,
              onSubmitted: (newValue) {
                setState(() async {
                  final res = await context
                      .read<Api>()
                      .editUserInfo(name: newValue, phone: phone);
                  Fluttertoast.showToast(msg: res);
                  _isEditingText = false;
                  _isEnableText = false;
                  FocusScope.of(context).unfocus();
                  inputText = newValue;
                });
                FocusScope.of(context).unfocus();
              },
              autofocus: _isEnableText,
              controller: _editingController,
            ),
          ),
        ),
      );
    return (_editingController.text == "")
        ? Text(
            inputText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          )
        : Text(
            _editingController.text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          );
  }

  void editName() {
    setState(() {
      _isEditingText = true;
      _isEnableText = true;
    });
  }
}

class ActivationListTile extends StatefulWidget {
  const ActivationListTile({Key key}) : super(key: key);

  @override
  _ActivationListTileState createState() => _ActivationListTileState();
}

class _ActivationListTileState extends State<ActivationListTile> {
  bool showActivationInput = false;

  @override
  Widget build(BuildContext context) {
    return showActivationInput
        ? ListTile(
            title: ActivationInput(
                onActivate: () => setState(() => showActivationInput = false)))
        : ListTile(
            leading: Icon(Icons.more_time_outlined),
            title: Text('Click here to extend activation'.tr()),
            onTap: () => setState(() => showActivationInput = true),
          );
  }
}
