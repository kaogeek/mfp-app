import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Auth/register-pass.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
      print('submit');
//    If all data are correct then save data to out variables
      _key.currentState.save();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PicProfile()),
      // );
    } else {
      print(' data are not valid');

//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //--------------------อีเมล----------------------//
    final TextFormField _txtEmail = TextFormField(
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.only(left: 30, top: 8),
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
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/shutterstock_553511089.png'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.19,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_sharp,
                            size: 40,
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
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height / 5.5,
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'สวัสดี,\n',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          children: [
                            TextSpan(
                                text: 'ยินดีต้อนรับเข้าสู่ แพลตฟอร์ม\n',
                                style: TextStyle(fontSize: 25)),
                            TextSpan(
                                text: 'ก้าวไกลทูเดย์',
                                style: TextStyle(fontSize: 25)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          'กรุณาใส่ Email ที่คุณจะใช้ในการสมัคร',
                          style: TextStyle(fontSize: 17, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                //--------------------อีเมล----------------------//
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.2, color: Colors.black12),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10.0))),
                  padding: EdgeInsets.only(bottom: 23),
                  child: _txtEmail,
                ),
                iserror == true
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          msg,
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      )
                    : Container(),

                SizedBox(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height / 3.0,
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
                                        ? nextpage()
                                        : _validateInputs();
                                  }
                                  //             Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => Registerpassword()),
                                  // );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                Spacer(),
                Container(
                  //color: Colors.black,
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: Text(
                      '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                      style: TextStyle(
                        color: Colors.white,
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
    await new Future.delayed(const Duration(milliseconds: 200));
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: Registerpassword(
              email: _email.text,
            )));
  }
}
