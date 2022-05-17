import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/like_button_widget.dart';
import 'package:flutter_application_1/component/button/round_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/jassy_gradient_color.dart';
import 'package:flutter_application_1/models/community.dart';
import 'package:flutter_application_1/theme/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../post_detail.dart';

class GroupActivityScreenBody extends StatefulWidget {
  final groupActivity;
  final user;

  const GroupActivityScreenBody(
      {Key? key, required this.groupActivity, required this.user})
      : super(key: key);

  @override
  State<GroupActivityScreenBody> createState() =>
      _GroupActivityScreenBodyState();
}

class _GroupActivityScreenBodyState extends State<GroupActivityScreenBody> {
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference community =
      FirebaseFirestore.instance.collection('Community');

  joinGroup() async {
    await community.doc(widget.groupActivity['groupid']).update({
      'membersID': FieldValue.arrayUnion([currentUser!.uid]),
    });
    await users.doc(currentUser!.uid).update({
      'groups': FieldValue.arrayUnion([widget.groupActivity['groupid']]),
    });
    Navigator.of(context).pop();
  }

  bool isNotificationOn = false;
  bool isSavedPost = false;

  bool isMember = false;
  Widget getButtonJoinGroup(size) {
    for (var groupid in widget.user['groups']) {
      if (groupid == widget.groupActivity['groupid']) {
        isMember = true;
      }
    }
    return isMember == true
        ? const SizedBox.shrink()
        : Center(
            child: RoundButton(
                text: "GroupJoin".tr,
                minimumSize: Size(size.width * 0.8, size.height * 0.05),
                press: () {
                  joinGroup();
                }),
          );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CurvedWidget(
            child: JassyGradientColor(
          gradientHeight: size.height * 0.23,
        )),
        // Todo: if now join show button if not join dont show button
        getButtonJoinGroup(size),
        SizedBox(
          height: size.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: textDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'kanit'),
                  children: [
                WidgetSpan(
                    child: SvgPicture.asset("assets/icons/group_activity.svg")),
                WidgetSpan(
                  child: SizedBox(
                    width: size.width * 0.01,
                  ),
                ),
                TextSpan(text: "GroupActivity".tr)
              ])),
        ),
        Expanded(
          child: ListView.separated(
              padding: EdgeInsets.only(top: size.height * 0.02),
              scrollDirection: Axis.vertical,
              itemCount: newsLists.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: size.height * 0.03,
                );
              },
              itemBuilder: (context, index) {
                // list of news card in group
                return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                        return PostDetail(
                          post: newsLists[index],
                        );
                      }));
                    },
                    child: groupNewsCard(newsLists[index], context));
              }),
        ),
      ],
    );
  }

// news card in group
  Widget groupNewsCard (News data, context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        decoration: BoxDecoration(
          color: textLight,
          border: Border(bottom: BorderSide(width: size.width * 0.01, color: primaryLightest))
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage("assets/images/user3.jpg"),
                  radius: size.width * 0.08,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.025,),
                        // post by
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: greyDark, fontSize: 14, fontFamily: 'kanit'),
                            children: [
                              TextSpan(text: "${'GroupPostBy'.tr} "),
                              const TextSpan(text: "Ammie "),
                              TextSpan(text: "${'GroupPostAt'.tr} "),
                              const TextSpan(text: "10:24 AM "),
                            ]                      
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
                      context: context, 
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20, bottom: 15),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          // Todo: saved post
                                          Navigator.pop(context);
                                          setState(() {
                                            isSavedPost = !isSavedPost;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            isSavedPost ? SvgPicture.asset("assets/icons/unsaved_list.svg") :SvgPicture.asset("assets/icons/saved_lists.svg"),
                                            SizedBox(width: size.width * 0.03,),
                                            isSavedPost ? const Text("เลิกบันทึกโพสต์") : const Text("เบันทึกโพสต์")
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          // Todo: Report
                                          // reportModalBottomSheet(context);
                                          // line 344
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset("assets/icons/report.svg"),
                                            SizedBox(width: size.width * 0.03,),
                                            const Text("รายงานโพสต์")
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          // Todo: delete post
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset("assets/icons/del_bin_circle.svg"),
                                            SizedBox(width: size.width * 0.03,),
                                            const Text("ลบโพสต์")
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            isNotificationOn = !isNotificationOn;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            isNotificationOn ? SvgPicture.asset("assets/icons/notification_off.svg") : SvgPicture.asset("assets/icons/notification_on.svg"),
                                            SizedBox(width: size.width * 0.03,),
                                            isNotificationOn ? Text("MenuNotificationOff".tr) : Text("MenuNotificationOn".tr)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight, 
                                child: IconButton(
                                  onPressed: () {Navigator.pop(context);}, 
                                  icon: const Icon(Icons.close, color: primaryDarker,)
                                )
                              ),
                            ],
                          ),
                        );
                      }
                    );
                  },
                  child: Icon(Icons.more_horiz, color: primaryColor, size: size.width * 0.08,)
                )
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02,),
          // post text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Container(
              constraints: const BoxConstraints(maxHeight: double.infinity),
              child: Text(data.news, maxLines: null, style: const TextStyle(fontSize: 18),),
            ),
          ),
          // Todo: if has image show
          // SizedBox(height: size.height * 0.02,),
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => FullScreenImage(context)),
          //     );
          //   },
            
          //   child: Container(
          //     constraints: BoxConstraints(maxHeight: size.height * 0.4, maxWidth: double.infinity),
          //     child: Hero(
          //       tag: 'post id',
          //       child: Image.asset("assets/images/user3.jpg", height: size.height * 0.4, width: double.infinity, fit: BoxFit.cover,)
          //     )
          //   ),
          // ),
          SizedBox(height: size.height * 0.03,),
          // like and comment icon
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Row(
              children: [
                const LikeButtonWidget(),
                SizedBox(width: size.width * 0.05),
                InkWell(
                  onTap: () {
                    // FocusScope.of(context).requestFocus(myFocusNode);
                  },
                  child: SvgPicture.asset("assets/icons/comment_icon.svg", width: size.width * 0.07,)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget FullScreenImage (context) {
    return Scaffold(
        body: DismissiblePage(
          onDismissed: () {
            Navigator.of(context).pop();
          },
          direction: DismissiblePageDismissDirection.multi,
          child: Hero(
            tag: 'post id',
            child: Image.asset(
              "assets/images/chat_message.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
            ),
          ),
        )
      );
  }
}

  // Future<dynamic> reportModalBottomSheet(BuildContext context) {
  //   return showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
  //       context: context,
  //       builder: (context) => Container(
  //             height: MediaQuery.of(context).size.height * 0.60,
  //             padding:
  //                 const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   "MenuReport".tr,
  //                   style: const TextStyle(fontSize: 16),
  //                 ),
  //                 Align(
  //                     alignment: Alignment.topLeft,
  //                     child: Text(
  //                       "ReportChoose".tr,
  //                       style: const TextStyle(fontSize: 16),
  //                     )),
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
  //                   child: Text(
  //                     "ReportDesc".tr,
  //                     style: const TextStyle(fontSize: 14, color: greyDark),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: SingleChildScrollView(
  //                     child: Column(
  //                       children: [
  //                         ReportTypeChoice(
  //                           text: 'ReportNudity'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportVio'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportThreat'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportProfan'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportTerro'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportChild'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportSexual'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportAnimal'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportScam'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportAbuse'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                         ReportTypeChoice(
  //                           text: 'ReportOther'.tr,
  //                           userid: widget.user['uid'],
  //                           chatid: widget.chatid,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ));
  // }
