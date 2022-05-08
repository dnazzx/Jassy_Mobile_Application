// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/admin/DashBoard/component/menu_card.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_card.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_card.dart';
import 'package:flutter_application_1/screens/main-app/chat/message_screen.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_picture_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
class DashboardScreenBody extends StatefulWidget {
  const DashboardScreenBody({Key? key, this.userData}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final userData;

  @override
  State<DashboardScreenBody> createState() => _DashboardScreenBody();
}

class _DashboardScreenBody extends State<DashboardScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  getDifferance(timestamp) {
    DateTime now = DateTime.now();
    DateTime lastActive = DateTime.parse(timestamp.toDate().toString());
    Duration diff = now.difference(lastActive);
    var timeMin = diff.inMinutes;
    var timeHour = diff.inHours;
    var timeDay = diff.inDays;
    if (timeMin < 3) {
      return 'Active a few minutes ago';
    } else if (timeMin < 60) {
      return 'Active ${timeMin.toString()} minutes ago';
    } else if (timeHour < 24) {
      return 'Active ${timeHour.toString()}h ago';
    } else if (timeDay < 3) {
      return 'Active ${timeDay.toString()}d ago';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      CurvedWidget(child: JassyGradientColor()),
      SizedBox(
        height: size.height * 0.04,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
        width: size.width,
        height: size.height * 0.15,
        decoration: BoxDecoration(
            color: textLight, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          MenuCard(
            size: size,
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.security),
              color: primaryColor,
            ),
            text: 'การจัดการผู้ดูแลระบบ',
            onTab: () {},
          ),
          MenuCard(
            size: size,
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.people_alt),
              color: primaryColor,
            ),
            text: 'การจัดการกลุ่มชุมชน',
            onTab: () {},
          ),
        ]),
      ),
      SizedBox(
        height: size.height * 0.03,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
        width: size.width,
        height: size.height * 0.075,
        decoration: BoxDecoration(
            color: textLight, borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          MenuCard(
            size: size,
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.report_problem_rounded),
              color: primaryColor,
            ),
            text: "คำร้องขอจากผู้ใช้งาน",
            onTab: () {},
          ),
        ]),
      ),
    ]);
  }
}
