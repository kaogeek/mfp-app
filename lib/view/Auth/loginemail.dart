import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/allWidget/sizeconfig.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/controller/auth_provider.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/internetConnectivity.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/register-email.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';

class Loginemail extends StatefulWidget {
  Loginemail({Key key}) : super(key: key);

  @override
  _LoginemailState createState() => _LoginemailState();
}

class _LoginemailState extends State<Loginemail> {
  bool isHiddenPassword = true;
  // bool _isloading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  var tokenvalue;
  var mytoken, userid;
  bool iserror = false;
  bool _isEnabled = true;
  String msgres = "";
  // Future<http.Response> singin(String email, String pass) async {
  //   final datacount = GetStorage();
  //   setState(() {
  //     _isloading = true;
  //   });
  //   print('singin');
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   var url = Uri.parse("${Api.url}api/login");
  //   Map data = {"username": email, "password": pass};
  //   final headers = {
  //     "mode": "EMAIL",
  //     "content-type": "application/json",
  //   };
  //   var body = jsonEncode(data);

  //   var res = await http.post(url, headers: headers, body: body);
  //   final jsonResponse = jsonDecode(res.body);

  //   if (res.statusCode == 200) {
  //     if (jsonResponse['status'] == 1) {
  //       print(jsonResponse['message']);
  //       msgres = jsonResponse['message'];
  //       if (jsonResponse != null) {
  //         sharedPreferences.setString(
  //             "token", '${jsonResponse["data"]["token"]}');
  //         datacount.write("token", '${jsonResponse["data"]["token"]}');
  //         sharedPreferences.setString(
  //             "myuid", '${jsonResponse["data"]["user"]["id"]}');
  //         sharedPreferences.setString(
  //             "imageURL", '${jsonResponse["data"]["user"]["imageURL"]}');

  //         sharedPreferences?.setBool("isLoggedIn", true);
  //         mytoken = jsonResponse["data"]["token"];
  //         userid = jsonResponse["data"]["user"]["id"];
  //         print("myuid$userid");

  //         if (mytoken != null) {
  //           _isloading = true;
  //         } else if (mytoken == null) {
  //           iserror = true;
  //         }

  //         Navigator.of(context).pushAndRemoveUntil(
  //             CupertinoPageRoute(
  //                 builder: (BuildContext context) => NavScreen()),
  //             (Route<dynamic> route) => false);
  //       } else {
  //         setState(() {
  //           _isloading = false;
  //         });
  //       }
  //     }
  //   }
  //   if (res.statusCode == 400) {
  //     if (jsonResponse['status'] == 0) {
  //       print(jsonResponse['message']);
  //       setState(() {
  //         msgres = jsonResponse['message'];
  //         _isloading = false;

  //         iserror = true;
  //       });
  //     }
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    checkInternetConnectivity().then((value) {
      value == true
          ? () {}()
          : Navigate.pushPageDialog(context, nonet(context));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    //--------------------อีเมล----------------------//
    final TextFormField _txtEmail = TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
        ),
        hintText: 'อีเมล',
        hintStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
        ),
        contentPadding: EdgeInsets.only(left: 30, top: 8),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _isEnabled = false;
          });
        }
        if (value == "") {
          setState(() {
            _isEnabled = true;
          });
        }
      },
      onSaved: (value) {
        authController.emailController.text = value;
      },
      // validator: (value) {
      //   return authController.validateemail(value);
      // },
    );
    //-------------------รหัสผ่าน---------------------//
    final TextFormField _txtPassword = TextFormField(
      controller: _passController,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
        ),
        hintStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
        ),
        hintText: 'รหัสผ่าน',
        suffixIcon: InkWell(
            onTap: _togglePasswordView,
            child: Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Icon(isHiddenPassword == true
                  ? Icons.visibility_off_outlined
                  : Icons.visibility),
            )),
        contentPadding: EdgeInsets.only(left: 30, top: 16),
        border: InputBorder.none,
      ),
      obscureText: isHiddenPassword,
      keyboardType: TextInputType.text,
      autocorrect: false,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _isEnabled = false;
          });
        }
        if (value == "") {
          setState(() {
            _isEnabled = true;
          });
        }
      },
      onSaved: (value) {
        authController.passController.text = value;
      },
      // validator: (value) {
      //   return authController.validatepassword(value);
      // },
    );
    // if (_emailController.text != "" && _passController.text != "") {
    //   _isEnabled = false;
    //   print('_isEnabled$_isEnabled');
    // }

    return Container(
      color: MColors.primaryWhite,
      child: Scaffold(
          body: Form(
        key: authController.loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color(0xFF0C3455), BlendMode.softLight),
                    image: AssetImage('images/shutterstock_553511089.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_sharp,
                                size: 40,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                  Get.reset();
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
                                image: AssetImage(
                                    'images/MFP-Logo-Horizontal.png'),
                              )),
                            ),
                          ],
                        ),
                      ),
                      if (!isKeyboard)
                        SizedBox(
                          height: SizeConfig.screenHeight / 3.8,
                        ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'เข้าสู่ระบบด้วย Email',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: AppTheme.FontAnakotmaiLight,
                          ),
                        ),
                      ),
                      //--------------------อีเมล----------------------//

                      Container(
                        height: SizeConfig.screenHeight * 0.07,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 1.2, color: Colors.black12),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0))),
                        child: _txtEmail,
                      ),
                      //-------------------รหัสผ่าน---------------------//
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: SizeConfig.screenHeight * 0.07,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 1.2, color: Colors.black12),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0))),
                        child: _txtPassword,
                      ),
                      Obx(() {
                        if (authController.iserror.value)
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              authController.msg,
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          );
                        else
                          return Container();
                      }),

                      //----------------ปุ่ม ลืมรหัสผ่านใช่ไหม ?--------------//
                      Obx(() {
                        if (authController.iserror.value)
                          return Center(
                            child: TextButton(
                              child: Text('ลืมรหัสผ่าน ?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: AppTheme.FontAnakotmaiLight,
                                  )),
                              onPressed: () {
                                print('กด');
                              },
                            ),
                          );
                        else
                          return Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              child: Text('ลืมรหัสผ่าน ?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: AppTheme.FontAnakotmaiLight,
                                  )),
                              onPressed: () {
                                print('กด');
                              },
                            ),
                          );
                      }),

                      //-------------------------------------------------------------------------------//
                      //-------------------------------------เข้าสู่ระบบ----------------------------------//

                      _isEnabled == false
                          ? Obx(() {
                              if (authController.isLoading.value)
                                return Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ElevatedButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                side: BorderSide(
                                                    color: Colors.red)),
                                            primary: MColors.primaryColor,
                                          ),
                                          onPressed: null,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: MColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              else
                                return Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ElevatedButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                side: BorderSide(
                                                    color: Colors.red)),
                                            backgroundColor:
                                                MColors.primaryColor,
                                          ),
                                          child: Text(
                                            'เข้าสู่ระบบ',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily:
                                                  AppTheme.FontAnakotmaiLight,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () async {
                                            print('กด');
                                            // setState(() {
                                            //   _isloading = true;
                                            // });
                                            await authController.checkLogin();
                                            await authController.login(
                                                _emailController.text,
                                                _passController.text);
                                            print(
                                                'isLogin${authController.isLogin.value}');

                                            if (authController.isLogin.value) {
                                              return Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      CupertinoPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              NavScreen()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                            } else {
                                              setState(() {
                                                iserror = true;
                                              });
                                              // return  showAboutDialog(context: context);
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                            })
                          : Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: RaisedButton(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          side: BorderSide(
                                              color: MColors.primaryColor)),
                                      child: Text(
                                        'เข้าสู่ระบบ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily:
                                              AppTheme.FontAnakotmaiLight,
                                        ),
                                      ),
                                      textColor: Colors.white,
                                      color:
                                          MColors.primaryColor.withOpacity(0.5),
                                      onPressed: () {},
                                    ),
                                  )
                                ],
                              ),
                            ),
                      //-------------------------------------------------------------------------------//
                      //-----------------------------------สมัครสมาชิก----------------------------------//
                      Center(
                        child: TextButton(
                          child: Text('สมัครสมาชิก',
                              style: TextStyle(
                                color: MColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: AppTheme.FontAnakotmaiLight,
                              )),
                          onPressed: () {
                            Navigate.pushPage(context, Register());
                          },
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: Text(
                      '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: AppTheme.FontAnakotmaiLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
}
