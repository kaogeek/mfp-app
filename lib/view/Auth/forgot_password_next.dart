import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Auth/forgot_password_build.dart';
import 'package:mfp_app/view/Auth/register_pic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Forget_Password_Next extends StatefulWidget {
  final String email;
  Forget_Password_Next({Key key, this.email}) : super(key: key);

  @override
  State<Forget_Password_Next> createState() => _Forget_Password_NextState();
}

class _Forget_Password_NextState extends State<Forget_Password_Next> {
  final _key = GlobalKey<FormState>();
  bool isvis = false;
  bool iserror = false;

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _otp = TextEditingController();

  String msg;
  bool _autoValidate = false;

  bool isregister = false;

  bool _isButtonDisabled = true;

  void _validateInputs() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFFFFFF),
              borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "หากคุณไม่ได้รับ อีเมล ?",
                  maxLines: 11,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
                MaterialButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("firstTime", "set");
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 12,
                    padding: EdgeInsets.all(15.0),
                    child: Material(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: 'helvetica_neue_light',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //--------------------อีเมล----------------------//
    final TextFormField _txtPassword = TextFormField(
      controller: _pass,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'รหัสผ่าน',
        contentPadding: EdgeInsets.all(13),
        border: InputBorder.none,
        labelStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
        ),
        hintStyle:
            TextStyle(fontFamily: AppTheme.FontAnakotmaiLight, fontSize: 14),
        suffixIcon: InkWell(
            child: Padding(
                padding: const EdgeInsets.all(13),
                child: isvis == false
                    ? null
                    : Icon(
                        Icons.check,
                        color: MColors.primaryColor,
                      ))),
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      validator: validatepassword,
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
    final TextFormField _txtCPassword = TextFormField(
      controller: _confirmPass,
      obscureText: true,
      style: TextStyle(fontSize: 14, fontFamily: AppTheme.FontAnakotmaiLight),
      decoration: InputDecoration(
        hintText: 'ใส่รหัสผ่านอีกครั้ง',
        contentPadding: EdgeInsets.all(13),
        labelStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
        ),
        hintStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
          fontSize: 14,
        ),
        border: InputBorder.none,
        suffixIcon: InkWell(
            // onTap: _togglePasswordView,
            child: Padding(
          padding: const EdgeInsets.all(13),
          child: isvis == false
              ? null
              : Icon(
                  Icons.check,
                  color: MColors.primaryColor,
                ),
        )),
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      validator: validatepassword,
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
    final TextFormField _Txtotp = TextFormField(
      controller: _otp,
      obscureText: false,
      style: TextStyle(fontSize: 14, fontFamily: AppTheme.FontAnakotmaiLight),
      decoration: InputDecoration(
        hintText: 'รหัสกู้คืน',
        contentPadding: EdgeInsets.all(13),
        labelStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
        ),
        hintStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
          fontSize: 14,
        ),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      // validator: validateotp,
      // onChanged: (value) {
      //   if (value != null) {
      //     setState(() {
      //       _isButtonDisabled = false;
      //     });
      //   }
      //   if (value == "") {
      //     setState(() {
      //       _isButtonDisabled = true;
      //     });
      //   }
      // },
    );

    return Form(
      key: _key,
      // autovalidate: _autoValidate,
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
                          print('กด');
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
                  height: MediaQuery.of(context).size.height / 8.0,
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Flexible(
                      // padding: EdgeInsets.only(left: 10),

                      // width: MediaQuery.of(context).size.width / 1.0,
                      // height: MediaQuery.of(context).size.height / 6.5,
                      // color: Colors.black,
                      child: Text(
                        "ป้อนรหัสการกู้คืน\nโปรดตรวจสอบ รหัสกู้คืน ที่ใช้สำหรับการรีเซ็ตรหัสผ่าน\nบัญชีก้าวไกลทูเดย์ที่อีเมลของคุณ",
                        maxLines: 4,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white70,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.2, color: Colors.black12),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10.0))),
                  child: _Txtotp,
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.02,
                  width: MediaQuery.of(context).size.width * 0.86,
                ),
                //--------------------อีเมล----------------------//
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.2, color: Colors.black12),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10.0))),
                  child: _txtPassword,
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.02,
                  width: MediaQuery.of(context).size.width * 0.86,
                ),
                //--------------------อีเมล----------------------//
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.2, color: Colors.black12),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10.0))),
                  child: _txtCPassword,
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      child: Text('ขอรหัสกู้คืนอีกครั้ง',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: AppTheme.FontAnakotmaiLight,
                          )),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                new CupertinoAlertDialog(
                                  title: new Text(
                                    "หากคุณไม่ได้รับ อีเมล ?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  content: new Text(
                                    widget.email,
                                    style: TextStyle(
                                        fontFamily:
                                            AppTheme.FontAnakotmaiMedium,
                                        fontSize: 18),
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: new Text("ยกเลิก"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    CupertinoDialogAction(
                                        child: new Text(
                                          "ส่งอีกครั้ง",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () async {
                                          Api.forgetpassword(widget.email);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Row(
                                              children: [
                                                Icon(
                                                  Icons.check,
                                                  color: MColors.primaryWhite,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('ส่งอีกครั้ง')
                                              ],
                                            ),
                                            duration: const Duration(
                                                milliseconds: 2500),
                                          ));
                                        }),
                                  ],
                                ));
                        //  Api.forgetpassword(widget.email);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      RichText(
                        maxLines: 5,
                        text: TextSpan(
                          text: '● รหัสผ่านควรมากกว่า 6 ตัวอักษรขึ้นไป,\n',
                          style: TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          children: [
                            TextSpan(
                                text:
                                    '● ประกอบด้วยตัวอักขระพิเศษอย่างน้อย 1 ตัว\n',
                                style: TextStyle(
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            TextSpan(
                                text: '● ต้องมีตัวพิมพ์ใหญ่อย่างน้อย 1 ตัว',
                                style: TextStyle(
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                                    style: TextStyle(fontSize: 20),
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
                                        ? nextpage(context)
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
                  //color: Colors.black,
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Text(
                      '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  String validateotp(String formOtp) {
    if (formOtp.isEmpty) return 'Password is required';
  }

  String validatepassword(String formPassword) {
    if (formPassword.isEmpty) return 'Password is required';
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(formPassword)) {
      msg = 'กรุณาตั้ง Password ให้ถูกต้องการเงือนไข';
      setState(() {
        iserror = true;
        isregister = false;
      });
    }
    if (regExp.hasMatch(formPassword)) {
      setState(() {
        isvis = true;
        iserror = false;
        isregister = true;
      });
    }
    if (_confirmPass.text != _pass.text) {
      msg = 'Passwordไม่ตรงกัน';
      setState(() {
        isvis = false;

        iserror = true;
        isregister = false;
      });
    }
    if (formPassword == _pass.text) {
      setState(() {
        isvis = true;
        iserror = false;
        isregister = true;
      });
    }

    return null;
  }

  nextpage(BuildContext context) async {
    print('nextpage');
    var jsonResponse;
    await Api.changepassword(widget.email, _pass.text, _otp.text)
        .then((value) => {
              jsonResponse = jsonDecode(value.body),
              print(jsonResponse),

              //(jsonResponse['status']);
              if (jsonResponse['status'] == 1)
                {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ForgotPasswordBuild(
                            displayName: jsonResponse['data']['displayName'],
                            image: jsonResponse['data']['imageURL'],
                          ))),
                },
              if (jsonResponse['status'] == 0)
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("ชื่อผู้ใช้ที่ไม่ถูกต้อง",
                        style:
                            TextStyle(fontFamily: AppTheme.FontAnakotmaiLight)),
                    backgroundColor: Colors.red,
                    duration: const Duration(milliseconds: 1000),
                  )),
                }
            });
  }
}
