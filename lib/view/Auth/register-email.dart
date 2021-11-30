import 'package:flutter/material.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/Auth/register-pass.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    //--------------------อีเมล----------------------//
    final TextField _txtEmail = TextField(
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.only(left: 30, top: 8),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
    );
    return Scaffold(
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
              SizedBox(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height / 3.0,
              ),
              Container(
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
                        color: Colors.orange[400],
                        onPressed: () {
                            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registerpassword()),
                );
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
    ));
  }
}
