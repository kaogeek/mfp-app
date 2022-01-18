import 'package:flutter/material.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Auth/register_pic.dart';
import 'package:page_transition/page_transition.dart';

class Registerpassword extends StatefulWidget {
  final String email;
  Registerpassword({Key key, this.email}) : super(key: key);

  @override
  _RegisterpasswordState createState() => _RegisterpasswordState();
}

class _RegisterpasswordState extends State<Registerpassword> {
  final _key = GlobalKey<FormState>();
  bool isvis = false;
  bool iserror = false;

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  String msg;
  bool _autoValidate = false;

  bool isregister = false;

  bool _isButtonDisabled = true;

  void _validateInputs() {
    if (_key.currentState.validate()) {
      // print('submit');
//    If all data are correct then save data to out variables
      _key.currentState.save();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PicProfile()),
      // );
    } else {
      // print(' data are not valid');

//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
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
        hintStyle: TextStyle(
          fontFamily: AppTheme.FontAnakotmaiLight,
          fontSize: 14
        ),
        suffixIcon: InkWell(
            // onTap: _togglePasswordView,
            child: Padding(
                padding: const EdgeInsets.all( 13),
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
      style:TextStyle(fontSize: 14,fontFamily: AppTheme.FontAnakotmaiLight),

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
          padding: const EdgeInsets.all( 13),
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

    return Form(
      key: _key,
      // autovalidate: _autoValidate,
      child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/shutterstock_553511089.png'),
              fit: BoxFit.cover,
            )),
            child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
              child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
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
                   Padding(
                     padding: const EdgeInsets.only(left: 10.0),
                     child: Container(
                        // color: Colors.black,
                        height: MediaQuery.of(context).size.height / 4.0,
                        width: MediaQuery.of(context).size.width / 1,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'สวัสดี,',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 30,
                                    overflow: TextOverflow.clip,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width/2.0,
                                child: Text(
                                  'ยินดีต้อนรับเข้าสู่ แพลตฟอร์ม',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 25,
                                      overflow: TextOverflow.clip,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'ก้าวไกลทูเดย์',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 25,
                                    overflow: TextOverflow.clip,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                   ),
                    Container(
                           width: MediaQuery.of(context).size.width /1,
                   margin: EdgeInsets.only(left: 10, right: 5),
                      child: Text(
                        'กรุณาใส่รหัสผ่าน',
                        maxLines: 1,
                        style: TextStyle(fontSize: 17, color: Colors.white70,overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    //--------------------อีเมล----------------------//
                    Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 1.2, color: Colors.black12),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0))),
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
                            border:
                                Border.all(width: 1.2, color: Colors.black12),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0))),
                      child: _txtCPassword,
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
              
                    Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: MediaQuery.of(context).size.width /1.1,
                      child: Row(
                        children: [
                          RichText(
                            maxLines: 5,
                            text: TextSpan(
                              text: '● รหัสผ่านควรมากกว่า 6 ตัวอักษรขึ้นไป,\n',
                              style: TextStyle(
                                  fontSize: 16,
                                  overflow:TextOverflow.ellipsis ,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              children: [
                                TextSpan(
                                    text:
                                        '● ประกอบด้วยตัวอักขระพิเศษอย่างน้อย 1 ตัว\n',
                                    style: TextStyle(fontSize: 16,                              overflow:TextOverflow.ellipsis ,
              )),
                                TextSpan(
                                    text: '● ต้องมีตัวพิมพ์ใหญ่อย่างน้อย 1 ตัว',
                                    style: TextStyle(fontSize: 16,                              overflow:TextOverflow.ellipsis ,
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
                                            ? nextpage()
                                            : _validateInputs();
                                      }
              
                                      // if (_key.currentState.validate()) {
                                      //      Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => PicProfile(email: "",password: "",)),
                                      // );
                                      // }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                    Container(
                      //color: Colors.black,
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: Text(
                          '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                          maxLines: 2,
                          style: TextStyle(color: Colors.white,overflow:TextOverflow.ellipsis ),
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

  nextpage() async {
    await new Future.delayed(const Duration(milliseconds: 200));
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: PicProfile(
              password: _confirmPass.text,
              email: widget.email,
            )));
  }
}
