// ignore_for_file: deprecated_member_use

import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_card.dart';
import 'package:flutter_application_1/screens/admin/Users/component/user_info.dart';
import 'package:flutter_application_1/screens/main-app/chat/component/chat_card.dart';
import 'package:flutter_application_1/screens/main-app/profile/component/profile_menu_widget.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// NOTE: chat card in all chat page show name lastest message and unread notification
class AdminScreenBody extends StatefulWidget {
  const AdminScreenBody({Key? key, this.userData}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final userData;

  @override
  State<AdminScreenBody> createState() => _AdminScreenBody();
}

class _AdminScreenBody extends State<AdminScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  bool isToggleShowUser = false;
  bool isSearchEmpty = true;
  String query = '';
  TextEditingController searchController = TextEditingController();

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
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      final isSearchEmpty = searchController.text.isNotEmpty;
      setState(() {
        this.isSearchEmpty = !isSearchEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 40;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const CurvedWidget(child: JassyGradientColor()),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          child: TextFormField(
            controller: searchController,
            onChanged: (desc) {
              desc = searchController.text;
              setState(() {});
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(
                'assets/icons/search_input.svg',
                height: 16,
              ),
              hintText: 'ค้นหา',
              filled: true,
              fillColor: textLight,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(color: textLight, width: 0.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(color: textLight),
              ),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .where('name.firstname',
                    isGreaterThanOrEqualTo: searchController.text.toLowerCase())
                .where('name.firstname',
                    isLessThan: searchController.text.toLowerCase() + 'z')
                .snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text(''),
                );
              }
              var data = snapshot.data!.docs;
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                itemCount: data.length,
                itemBuilder: (context, int index) {
                  if (data[index]['userStatus'] == 'admin') {
                    if (searchController.text.toLowerCase() == '') {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.height * 0.01),
                            width: size.width,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                                color: textLight,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(children: [
                              UserCard(
                                size: size,
                                icon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.verified_rounded),
                                  color: data[index]['isAuth'] == true
                                      ? data[index]['report'].length < 5
                                          ? primaryColor
                                          : greyDark
                                      : textLight,
                                ),
                                text: StringUtils.capitalize(data[index]['name']
                                                ['firstname']) ==
                                            '' &&
                                        StringUtils.capitalize(data[index]
                                                ['name']['lastname']) ==
                                            ''
                                    ? '-'
                                    : '${StringUtils.capitalize(data[index]['name']['firstname'])} ${StringUtils.capitalize(data[index]['name']['lastname'])}',
                                reportIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(data[index]['report'].length < 5
                                      ? Icons.warning_rounded
                                      : Icons.cancel_rounded),
                                  color: data[index]['report'].length < 3
                                      ? textLight
                                      : data[index]['report'].length < 5
                                          ? tertiary
                                          : textLight,
                                ),
                                onTab: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        UserInfoPage(data[index]),
                                  );
                                },
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.height * 0.01),
                            width: size.width,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                                color: textLight,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(children: [
                              UserCard(
                                size: size,
                                icon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.verified_rounded),
                                  color: data[index]['isAuth'] == true
                                      ? data[index]['report'].length < 5
                                          ? primaryColor
                                          : greyDark
                                      : textLight,
                                ),
                                text: StringUtils.capitalize(data[index]['name']
                                                ['firstname']) ==
                                            '' &&
                                        StringUtils.capitalize(data[index]
                                                ['name']['lastname']) ==
                                            ''
                                    ? '-'
                                    : '${StringUtils.capitalize(data[index]['name']['firstname'])} ${StringUtils.capitalize(data[index]['name']['lastname'])}',
                                reportIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(data[index]['report'].length < 5
                                      ? Icons.warning_rounded
                                      : Icons.cancel_rounded),
                                  color: data[index]['report'].length < 3
                                      ? textLight
                                      : data[index]['report'].length < 5
                                          ? tertiary
                                          : textLight,
                                ),
                                onTab: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        UserInfoPage(data[index]),
                                  );
                                },
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                        ],
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
