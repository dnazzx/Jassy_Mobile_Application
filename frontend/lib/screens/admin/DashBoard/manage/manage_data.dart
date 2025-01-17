// ignore_for_file: deprecated_member_use

import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/manage/manage_country.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/manage/manage_language.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/manage/manage_level.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_card.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_card.dart';
import 'package:flutter_application_1/screens/main-app/chat/message_screen.dart';
import 'package:flutter_application_1/screens/main-app/community/community.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_picture_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
class ManageScreenBody extends StatefulWidget {
  const ManageScreenBody({Key? key, this.userData}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final userData;

  @override
  State<ManageScreenBody> createState() => _ManageScreenBody();
}

class _ManageScreenBody extends State<ManageScreenBody> {
  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BackAndCloseAppBar(text: "การจัดการข้อมูลแอปพลิเคชั่น"),
      body: Column(children: [
        CurvedWidget(child: JassyGradientColor()),
        SizedBox(
          height: size.height * 0.04,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
          width: size.width,
          height: size.height * 0.21,
          decoration: BoxDecoration(
              color: textLight, borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            MenuCard(
              size: size,
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                color: primaryColor,
              ),
              text: 'การจัดการประเทศที่รองรับ',
              onTab: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return ManageCountryScreenBody();
                }));
              },
            ),
            MenuCard(
              size: size,
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.translate_rounded),
                color: primaryColor,
              ),
              text: 'การจัดการภาษา',
              onTab: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return ManageLanguageScreenBody();
                }));
              },
            ),
            MenuCard(
              size: size,
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.now_widgets_rounded),
                color: primaryColor,
              ),
              text: 'การจัดการระดับภาษา',
              onTab: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return ManageLevelScreenBody();
                }));
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
