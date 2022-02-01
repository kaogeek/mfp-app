import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Auth/forgot_password_next.dart';
import 'package:mfp_app/view/Auth/register-pass.dart';
import 'package:page_transition/page_transition.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _key = GlobalKey<FormState>();
  bool isvis = false;
  bool iserror = false;

  final TextEditingController _email = TextEditingController();

  String msg;
  bool _autoValidate = false;
  bool _isButtonDisabled = true;

  bool isregister = false;
  void _validateInputs() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    //--------------------อีเมล----------------------//
    final TextFormField _txtEmail = TextFormField(
      controller: _email,
      style: TextStyle(fontSize: 14, fontFamily: AppTheme.FontAnakotmaiLight),
      decoration: InputDecoration(
        hintText: 'อีเมล',
        hintStyle:
            TextStyle(fontSize: 14, fontFamily: AppTheme.FontAnakotmaiLight),
        contentPadding: EdgeInsets.all(13),
        border: InputBorder.none,
        suffixIcon: InkWell(
            // onTap: _togglePasswordView,
            child: Padding(
                padding: const EdgeInsets.only(top: 13),
                child: isvis == false
                    ? null
                    : Icon(
                        Icons.check,
                        color: MColors.primaryColor,
                      ))),
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      validator: validateemail,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _isButtonDisabled = false;
          });
        }
        if (value == "") {
          setState(() {
            _isButtonDisabled = true;
          });
        }
      },
    );
    return Form(
      key: _key,
      child: Scaffold(
          body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/shutterstock_553511089.png'),
            colorFilter: ColorFilter.mode(Colors.grey[500], BlendMode.modulate),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.19,
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: AppTheme.splashRadius,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // print('กด');
                        },
                      ),
                      Spacer(),
                      Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('images/MFP-Logo-Horizontal.png'),
                        )),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height / 7.0,
                  width: MediaQuery.of(context).size.width / 1,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'หากคุณลืมรหัสผ่าน\nก้าวไกลทูเดย์,',
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 30,
                              overflow: TextOverflow.clip,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),

                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //       'หากคุณประสบปัญหาเมื่อพยายาม\nลงชื่อเข้าใช้ด้วยรหัสผ่าน บัญชีผู้ใช้\nก้าวไกลทูเดย์ของคุณ ใช้ขั้นตอนนี้เพื่อรีเซ็ต\nและรับคืนสิทธิ์การเข้าสู่บัญชีผู้ใช้ก้าวไกลทูเดย์',
                      //     style: TextStyle(
                      //   fontSize: 17,
                      //   color: Colors.white70,
                      //   overflow: TextOverflow.ellipsis),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),

                    width: MediaQuery.of(context).size.width / 1.0,
                    height: MediaQuery.of(context).size.height / 5.0,
                    // color: Colors.black,
                    child: Text(
                      'หากคุณประสบปัญหาเมื่อพยายาม\nลงชื่อเข้าใช้ด้วยรหัสผ่าน บัญชีผู้ใช้\nก้าวไกลทูเดย์ของคุณ ใช้ขั้นตอนนี้เพื่อรีเซ็ต\nและรับคืนสิทธิ์การเข้าสู่บัญชีผู้ใช้ก้าวไกลทูเดย์',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white70,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
                //  if (!isKeyboard)
                //         SizedBox(
                //           height: MediaQuery.of(context).size.height / 8.5,
                //         ),

                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    'กรุณากรอก อีเมล ที่คุณใช้ในการสมัคร',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white70,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),

                //--------------------อีเมล----------------------//
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.2, color: Colors.black12),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10.0))),
                  child: _txtEmail,
                ),
                iserror == true
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          msg,
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      )
                    : Container(),

                Container(
                  // color: Colors.black,
                  height: MediaQuery.of(context).size.height / 10.0,
                ),
                _isButtonDisabled == true
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                  padding: EdgeInsets.only(top: 15, bottom: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Colors.red)),
                                  child: Text(
                                    'ถัดไป',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily:
                                            AppTheme.FontAnakotmaiLight),
                                  ),
                                  textColor: Colors.white,
                                  color: MColors.primaryColor.withOpacity(0.5),
                                  onPressed: () {}),
                            )
                          ],
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.red)),
                                child: Text(
                                  'ถัดไป',
                                  style: TextStyle(fontSize: 20),
                                ),
                                textColor: Colors.white,
                                color: MColors.primaryColor,
                                onPressed: () {
                                  if (_key.currentState.validate()) {
                                    _validateInputs();
                                    isregister == true
                                        ? nextpage()
                                        : _validateInputs();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),

                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Text(
                      '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: AppTheme.FontAnakotmaiLight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  String validateemail(String formEmail) {
    if (formEmail.isEmpty) {
      msg = 'Email ของคุณไม่ถูกต้องกรุณาใส่ Email ใหม่';
    }
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(formEmail)) {
      msg = 'Email ของคุณไม่ถูกต้องกรุณาใส่ Email ใหม่';
      setState(() {
        iserror = true;
        isregister = false;
      });
    }
    if (regExp.hasMatch(formEmail)) {
      setState(() {
        isvis = true;
        iserror = false;
        isregister = true;
      });
    }
    return null;
  }

  nextpage() async {
    var jsonResponse;
    Api.forgetpassword(_email.text).then((value) => {
          jsonResponse = jsonDecode(value.body),
          print(jsonResponse),

          //(jsonResponse['status']);
          if (jsonResponse['status'] == 1)
            {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Forget_Password_Next(
                        email: _email.text,
                      ))),
            },
          if (jsonResponse['status'] == 0)
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("ชื่อผู้ใช้ที่ไม่ถูกต้อง",
                    style: TextStyle(fontFamily: AppTheme.FontAnakotmaiLight)),
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 1000),
              )),
            }
        });
  }
}
