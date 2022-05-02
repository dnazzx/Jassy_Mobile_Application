import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/button/icon_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style3.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/no_account_register.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/theme/index.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  bool isHiddenPassword = true;
  RegExp regex = RegExp("(?=.*[A-Z])(?=.*[a-z])(?=.*?[!@#\$&*~.]).{8,}");
  TextEditingController passwordController = TextEditingController();

  CountryCode? countryCode = CountryCode();
  String getCoutryCode = '';

  void getCountry(CountryCode? countryCode) {
    getCoutryCode = countryCode.toString();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumberController.dispose();
    super.dispose();
  }

  //TODO: signin service function - facebook, google, phone
  Future _facebookLogin(BuildContext context) async {
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      var currentUser = FirebaseAuth.instance.currentUser;
      var users = FirebaseFirestore.instance.collection('Users');
      var queryUser = users.where('uid', isEqualTo: currentUser!.uid);
      var snapshot = await queryUser.get();
      final data = snapshot.docs[0];

      if (data['isAuth'] == true) {
        Navigator.of(context).pushNamed(Routes.JassyHome);
      } else {
        Navigator.of(context).pushNamed(Routes.RegisterProfile);
      }
    } on FirebaseAuthException catch (e) {
      //TODO: handle failed
    }
  }

  Future _googleLogin(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      var currentUser = FirebaseAuth.instance.currentUser;
      var users = FirebaseFirestore.instance.collection('Users');
      var queryUser = users.where('uid', isEqualTo: currentUser!.uid);
      var snapshot = await queryUser.get();
      final data = snapshot.docs[0];

      if (data['isAuth'] == true) {
        Navigator.of(context).pushNamed(Routes.JassyHome);
      } else {
        Navigator.of(context).pushNamed(Routes.RegisterProfile);
      }
    } on FirebaseAuthException catch (e) {
      //TODO: handle failed
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CurvedWidget(child: HeaderStyle3()),
          const HeaderText(text: "ยินดีต้อนรับการกลับมา !"),
          const DescriptionText(
              text: "เข้าสู่ระบบเพื่อเริ่มต้นการแลกเปลี่ยนภาษาของคุณ"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
            child: Row(
              children: [
                IconButtonComponent(
                  text: "Google",
                  minimumSize: Size(size.width * 0.4, size.height * 0.05),
                  press: () => _googleLogin(context),
                  iconPicture: SvgPicture.asset("assets/icons/google.svg",
                      height: size.height * 0.027),
                  color: textLight,
                  textColor: greyDarker,
                ),
                IconButtonComponent(
                  text: "Facebook",
                  minimumSize: Size(size.width * 0.4, size.height * 0.05),
                  press: () => _facebookLogin(context),
                  iconPicture: SvgPicture.asset("assets/icons/facebook.svg",
                      height: size.height * 0.027),
                  color: facebookColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          const Center(
              child: Text(
            "หรือเข้าสู่ระบบด้วย",
            style: TextStyle(color: greyDark),
          )),
          SizedBox(
            height: size.height * 0.01,
          ),
          Expanded(
            child: Column(
              children: [
                const RequiredTextFieldLabel(textLabel: "เบอร์โทรศัพท์"),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
                  child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(9)],
                    decoration: InputDecoration(
                        hintText: "Phone number",
                        fillColor: textLight,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide:
                                const BorderSide(color: textLight, width: 0.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: const BorderSide(color: textLight),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          borderSide: const BorderSide(color: textLight),
                        ),
                        prefixIcon: CountryCodePicker(
                          initialSelection: "+66",
                          countryFilter: const ["+66", "+62", "+82"],
                          onInit: getCountry,
                          onChanged: getCountry,
                          showDropDownButton: true,
                          flagWidth: 25,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 9) {
                        return "กรอกให้ครบ";
                      }
                      return null;
                    },
                    onSaved: (String? phoneNumber) {
                      phoneNumber = phoneNumberController.text;
                    },
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: DisableToggleButton(
                text: "เข้าสู่ระบบ",
                minimumSize: const Size(339, 36),
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    String phone =
                        getCoutryCode + '${phoneNumberController.text}';
                    print(phone);
                    Navigator.pushNamed(context, Routes.EnterOTP,
                        arguments: [phone, 'PhoneLoginPage'.tr]);
                  }
                }),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          const Center(child: NoAccountRegister()),
          SizedBox(
            height: size.height * 0.08,
          ),
        ],
      ),
    );
  }
}