import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:coupons/services/authService.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _verificationId;
  bool incorrectCode = false;
  bool verificationCodeSent = false;
  String selectedCode;
  bool sendingCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Center(
                child: Image.asset("assets/images/Saving-logo.png"),
              ),
            ),
            // Positioned(
            //   top: 20,
            //   right: 20,
            //   child: Card(
            //     elevation: 10,
            //     child: LangaugeDropdown(
            //       value: EasyLocalization.of(context).locale.languageCode,
            //       onChange: (value) {
            //         EasyLocalization.of(context).setLocale(Locale(value));
            //       },
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.all(20),
              child:
                  verificationCodeSent ? renderCodePage() : renderPhoneInput(),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderCodePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                verificationCodeSent = false;
              });
            }),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Verification code'.tr()),
              PinFieldAutoFill(
                onCodeChanged: (String code) {
                  setState(() {
                    incorrectCode = false;
                  });
                  if (code.length == 6) {
                    signInWithPhoneNumber(code);
                  }
                },
                autofocus: true,
                controller: _smsController,
                currentCode: _smsController.text,
                textInputAction: TextInputAction.done,
                decoration: UnderlineDecoration(
                  errorText: incorrectCode ? 'Incorrect code'.tr() : '',
                  colorBuilder:
                      PinListenColorBuilder(Colors.black, Colors.grey),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget renderPhoneInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Row(
            children: [
              CountryCodePicker(
                onChanged: (CountryCode code) => selectedCode = code.dialCode,
                onInit: (CountryCode code) => selectedCode = code.dialCode,
                initialSelection: 'IQ',
                favorite: ['IQ', 'TR'],
                textStyle: TextStyle(color: Colors.grey, fontSize: 20),
                enabled: !sendingCode,
              ),
              // SizedBox(width: 10),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _phoneNumberController,
                  enabled: !sendingCode,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'PhoneNumber'.tr(),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        TextButton(
          onPressed: () {
            verifyPhoneNumber();
          },
          style: TextButton.styleFrom(
            primary: Colors.pink,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          ),
          child: sendingCode
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                )
              : Text(
                  'Login'.tr(),
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        )
      ],
    );
  }

  void signInWithPhoneNumber(code) async {
    try {
      context.read<AuthService>().signInWithPhoneNumber(code, _verificationId);
    } catch (e) {
      setState(() => incorrectCode = true);
    }
  }

  void verifyPhoneNumber() async {
    try {
      setState(() {
        sendingCode = true;
      });
      await SmsAutoFill().listenForCode;
      await context.read<AuthService>().verifyPhoneNumber(
            phoneNumber: selectedCode + _phoneNumberController.text,
            verificationFailed: (String msg) => showSnackbar(msg),
            codeAutoRetrievalTimeout: (String verificationId) =>
                _verificationId = verificationId,
            codeSent: (String verificationId, [int forceResendingToken]) async {
              Fluttertoast.showToast(msg: "Verification code sent".tr());
              _verificationId = verificationId;

              setState(() {
                verificationCodeSent = true;
                sendingCode = false;
              });
            },
          );
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number".tr() + ": $e");
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
