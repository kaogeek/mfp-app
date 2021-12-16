import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/model/postModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController, passController;
  var email = "";
  var password = "";
  var isLoading = false.obs;
  var isLogin = false.obs;
  var token = "";
  var msg = "";
  var iserror = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passController = TextEditingController();
    // login(emailController.text, passController.text);
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }

  String validateemail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'กรุณาใส่อีเมล์';
    }
    return null;
  }

  String validatepassword(String value) {
    if (value.length < 6) {
      return 'รหัสต้องมากว่า6';
    }
    return null;
  }

  checkLogin() {
    final isValid = !loginFormKey.currentState.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState.save();
  }

  // Future login(String email, String password) async {
  //   try {
  //     isLoading(true);
  //     token = await Api.singin(email, password);

  //     if (token != null) {
  //       isLogin.value = true;
  //     }
  //     if (token == null) {
  //       isLogin.value = false;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  Future login(String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      isLoading(true);
      final res = await Api.singin(email, password);

      final jsonResponse = jsonDecode(res.body);

      if (res.statusCode == 200) {
        token = jsonResponse["data"]["token"];

        if (jsonResponse['status'] == 1) {
          print(jsonResponse['message']);
          var msgres = jsonResponse['message'];
          if (jsonResponse != null) {
            sharedPreferences.setString(
                "token", '${jsonResponse["data"]["token"]}');
            sharedPreferences.setString(
                "myuid", '${jsonResponse["data"]["user"]["id"]}');
            sharedPreferences.setString(
                "imageURL", '${jsonResponse["data"]["user"]["imageURL"]}');
            sharedPreferences.setString("mode", 'EMAIL');

            sharedPreferences?.setBool("isLoggedIn", true);

            var userid = jsonResponse["data"]["user"]["id"];

            if (token != null) {
              isLogin.value = true;
              iserror.value = false;
              msg = msgres;
            } else if (token == null) {
              msg = msgres;
              iserror.value = true;
              isLogin.value = false;
            }

            // Navigator.of(context).pushAndRemoveUntil(
            //     CupertinoPageRoute(
            //         builder: (BuildContext context) => NavScreen()),
            //     (Route<dynamic> route) => false);
          } else {
            // setState(() {
            //   _isloading = false;
            // });
          }
        }
      }
      if (res.statusCode == 400) {
        if (jsonResponse['status'] == 0) {
          iserror.value = true;
          msg = jsonResponse['message'];
          print(jsonResponse['message']);
          if (msg == "Invalid Password") {
            msg = "รหัสผ่านไม่ถูกต้อง";
          }
          if (msg == "Invalid username") {
            msg = "ชื่อผู้ใช้หรืออีเมล์ไม่ถูกต้อง";
          }

          return jsonResponse['message'];
          // setState(() {
          //   msgres = jsonResponse['message'];
          //   _isloading = false;

          //   iserror = true;
          // });
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
