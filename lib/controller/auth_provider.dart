import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/model/postModel.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController, passController;
  var email = "";
  var password = "";
  var isLoading = false.obs;
  var isLogin = false.obs;
  var token = "";

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passController = TextEditingController();
    login(emailController.text, passController.text);
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

  Future login(String email, String password) async {
    try {
      isLoading(true);
      token = await Api.singin(email, password);

      if (token != null) {
        isLogin.value = true;
      }
      if (token == null) {
        isLogin.value = false;
      }
    } finally {
      isLoading(false);
    }
  }
}
