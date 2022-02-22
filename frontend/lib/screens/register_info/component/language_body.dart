import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/button/disable_toggle_button.dart';
import 'package:flutter_application_1/component/curved_widget.dart';
import 'package:flutter_application_1/component/header_style/header_style2.dart';
import 'package:flutter_application_1/component/input_feilds/required_text_field_label.dart';
import 'package:flutter_application_1/component/text/description_text.dart';
import 'package:flutter_application_1/component/text/header_text.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/theme/index.dart';


class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Name name = Name();
  Info userInfo = Info();
  User user = User();
  late FixedExtentScrollController countryScrollController;
  late FixedExtentScrollController defaultScrollController;
  late FixedExtentScrollController defaultLevelScrollController;
  late FixedExtentScrollController interestScrollController;
  late FixedExtentScrollController interestLevelScrollController;

  final languageLevelItems = ['beginner', 'intermediate', 'Advance'];
  final languageItems = ['ไทย', 'korean', 'Indonsian'];

  int countryIndex = 0;
  int defaultIndex = 0;
  int defaultLevelIndex = 0;
  int interestIndex = 0;
  int interestLevelIndex = 0;

  @override
  void initState() {
    super.initState();

    countryScrollController = FixedExtentScrollController(initialItem: countryIndex);
    defaultScrollController = FixedExtentScrollController(initialItem: defaultIndex);
    defaultLevelScrollController = FixedExtentScrollController(initialItem: defaultLevelIndex);
    interestScrollController = FixedExtentScrollController(initialItem: interestIndex);
    interestLevelScrollController = FixedExtentScrollController(initialItem: interestLevelIndex);
  }

  @override
  void dispose() {
    countryScrollController.dispose();
    defaultScrollController.dispose();
    defaultLevelScrollController.dispose();
    interestScrollController.dispose();
    interestLevelScrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CurvedWidget(
              child: HeaderStyle2(),
            ),
            HeaderText(text: "ข้อมูลภาษา"),
            DescriptionText(text: "คุณไม่สามารถเปลี่ยนสัญชาติและภาษาแม่หลังจากนี้ได้ดังนั้นโปรดให้ข้อมูลส่วนบุคคลที่แท้จริง"),
            RequiredTextFieldLabel(textLabel: "คุณเป็นคนประเทศ"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    countryScrollController.dispose;
                    countryScrollController = FixedExtentScrollController(initialItem: countryIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          countryalityPicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageItems[countryIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  onSaved: (String? country) {
                    userInfo.country = languageItems[countryIndex];
                  },
                ),
            ),
            RequiredTextFieldLabel(textLabel: "ภาษาแม่"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    defaultScrollController.dispose;
                    defaultScrollController = FixedExtentScrollController(initialItem: defaultIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          defaultLanguagePicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageItems[defaultIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  onSaved: (String? defaultLanguage) {
                    userInfo.defaultLanguage = languageItems[defaultIndex];
                  },
                ),
            ),
            RequiredTextFieldLabel(textLabel: "ระดับภาษาแม่"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    defaultLevelScrollController.dispose;
                    defaultLevelScrollController = FixedExtentScrollController(initialItem: defaultLevelIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          defaultLanguageLevelPicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageLevelItems[defaultLevelIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  onSaved: (String? defaultLevel) {
                    userInfo.levelDefaultLanguage = languageItems[defaultLevelIndex];
                  },
                ),
            ),
            RequiredTextFieldLabel(textLabel: "ภาษาที่สนใจ"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    interestScrollController.dispose;
                    interestScrollController = FixedExtentScrollController(initialItem: interestIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          interestLanguagePicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageItems[interestIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  onSaved: (String? interestLanguage) {
                    userInfo.interestedLanguage = languageItems[interestIndex];
                  },
                ),
            ),
            RequiredTextFieldLabel(textLabel: "ระดับภาษาที่สนใจ"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
              child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    interestLevelScrollController.dispose;
                    interestLevelScrollController = FixedExtentScrollController(initialItem: interestLevelIndex);
                    showCupertinoModalPopup(
                      context: context, 
                      builder: (context) { 
                        return CupertinoActionSheet(
                        actions: [
                          interestLevelLanguagePicker()
                        ],
                      );}
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    labelText: languageLevelItems[interestLevelIndex],
                    fillColor: textLight,
                    filled: true,
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 20,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(color: textLight, width: 0.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide:  const BorderSide(color: textLight ),
                    ),
                  ),
                  onSaved: (String? interestLevel) {
                    userInfo.levelInterestedLanguage = languageItems[interestLevelIndex];
                  },
                ),
            ),
            Center(
              child: DisableToggleButton(
                text: "next",
                minimumSize: Size(279, 36),
                press: () {
                  _formKey.currentState!.save();
                 print("${userInfo.country}");
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const EnterOTP()),
                // );
                // }    
              },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget countryalityPicker () {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: countryScrollController,
              itemExtent: 40,
              children: languageItems
                .map((item) => Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                   ),
                 ))
                .toList(),
              onSelectedItemChanged: (value) {
                setState(() {
                  this.countryIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }

  Widget defaultLanguagePicker () {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: defaultScrollController,
              itemExtent: 40,
              children: languageItems
                .map((item) => Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                   ),
                 ))
                .toList(),
              onSelectedItemChanged: (value) {
                setState(() {
                  this.defaultIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }
  
  Widget defaultLanguageLevelPicker () {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: defaultLevelScrollController,
              itemExtent: 40,
              children: languageLevelItems
                .map((item) => Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                   ),
                 ))
                .toList(),
              onSelectedItemChanged: (value) {
                setState(() {
                  this.defaultLevelIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }

  Widget interestLanguagePicker () {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: interestScrollController,
              itemExtent: 40,
              children: languageItems
                .map((item) => Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                   ),
                 ))
                .toList(),
              onSelectedItemChanged: (value) {
                setState(() {
                  this.interestIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }

  Widget interestLevelLanguagePicker () {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: CupertinoPicker(
              scrollController: interestLevelScrollController,
              itemExtent: 40,
              children: languageLevelItems
                .map((item) => Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 16),
                   ),
                 ))
                .toList(),
              onSelectedItemChanged: (value) {
                setState(() {
                  this.interestLevelIndex = value;
                });
              },
            ),
           ),
        ],
      ),
    );
  }
}