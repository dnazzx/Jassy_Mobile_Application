import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/back_close_appbar.dart';
import 'package:flutter_application_1/screens/forgot_password/email/component/email_otp_body.dart';
class EmailOTP extends StatelessWidget {
  const EmailOTP({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: BackAndCloseAppBar(text: 'ลืมรหัสผ่าน'),
      body: Body(),
      );
  }
}