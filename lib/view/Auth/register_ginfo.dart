import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/internetConnectivity.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/register-buildprofile.dart';
import 'package:http/http.dart' as http;
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Generalinformation extends StatefulWidget {
  final String email;

  final String password;
  final String img64;
  final File fileimg;
  final String name;
  final String firstname;
  final String lastname;
  final DateTime birthdate;
  final String fbid;
  final String mode;
  final String fbtoken;
  final DateTime fbexpires;

  Generalinformation(
      {Key key,
      this.email,
      this.password,
      this.img64,
      this.fileimg,
      this.name,
      this.firstname,
      this.lastname,
      this.birthdate,
      this.fbid,
      this.mode,
      this.fbtoken,
      this.fbexpires})
      : super(key: key);

  @override
  _GeneralinformationState createState() => _GeneralinformationState();
}

class _GeneralinformationState extends State<Generalinformation> {
  int group = 1;
  bool isclick = false;
  String _selectedValue;
  TextEditingController _email;
  TextEditingController _name;
  final TextEditingController _uniqueid = TextEditingController();

  TextEditingController _firstname;
  TextEditingController _lastname;
  final TextEditingController _birthday = new TextEditingController();
  final TextEditingController _customGender = TextEditingController();

  DateTime date;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _genderType = <String>[
    'ผู้ชาย',
    'ผู้หญิง',
    'อื่นๆ',
  ];
  bool _autoValidate = false;

  int gendertypeint;

  var mybody;

  bool isregister = false;

  String msg = "";

  var mytoken;
  bool ischeckuniqueid;

  bool _isButtonDisabled = true;

  var mybody1;

  bool isregisterfb = false;
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      print('submit');
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
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
  void initState() {
    // TODO: implement initState
    _email = new TextEditingController(text: widget.email);
    _name = new TextEditingController(text: widget.name);
    _firstname = new TextEditingController(text: widget.firstname);
    _lastname = new TextEditingController(text: widget.lastname);
    checkInternetConnectivity().then((value) {
      value == true
          ? () {}()
          : Navigate.pushPageDialog(context, nonet(context));
    });
    super.initState();
  }

  Future<http.Response> Register(
    String email,
    String password,
    String displayName,
    String username,
    String firstName,
    String lastName,
    String uniqueId,
    DateTime birthdate,
    int gender,
    String customGender,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isclick = true;
    });
    try {
      var url =
          Uri.parse("https://today-api.moveforwardparty.org/api/register");
      final headers = {
        "mode": "EMAIL",
        "content-type": "application/json",
      };

      Map data = {
        "username": username,
        "displayName": displayName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "uniqueId": uniqueId,
        "birthdate": birthdate.toIso8601String(),
        "gender": gender,
        "customGender": customGender,
        "asset": {},
      };
      //encode Map to JSON
      var body = jsonEncode(data);
      print(body);

      var responsepostRequest =
          await http.post(url, headers: headers, body: body);
      print("${responsepostRequest.statusCode}");
      print("${responsepostRequest.body}");
      final jsonResponse = jsonDecode(responsepostRequest.body);
      print('Registerbody${responsepostRequest.body}');
      msg = jsonResponse['message'];

      if (responsepostRequest.statusCode == 200) {
        mybody = jsonResponse["data"];

        if (jsonResponse['status'] == 1) {
          setState(() {
            isregister = true;
            msg = msg;

            print("Response status :${jsonResponse.statusCode}");
            print("Response status :${jsonResponse.body}");
            sharedPreferences.setString(
                "token", '${jsonResponse["data"]["token"]}');
            mytoken = jsonResponse["data"]["token"];
          });
        }
      }

      if (jsonResponse.statusCode == 400) {
        if (jsonResponse['status'] == 0) {
          setState(() {
            isregister = false;
            msg = msg;

            // _isloading = false;

            // iserror = true;
          });
        }
      }
      print('msg$msg');

      return responsepostRequest;
    } catch (e) {
      print(e.toString());
      showAlertDialog(context);
      setState(() {
        isclick = false;
      });
    }
  }

  Future<http.Response> fbregister(
    String email,
    String password,
    String displayName,
    String username,
    String firstName,
    String lastName,
    String uniqueId,
    DateTime birthdate,
    int gender,
    String customGender,
    String imageb64,
    String fbid,
    String fbToken,
    DateTime fbexpires,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isclick = true;
    });
    try {
      var url =
          Uri.parse("https://today-api.moveforwardparty.org/api/register");
      final headers = {
        "mode": "FACEBOOK",
        "content-type": "application/json",
      };
      Map data = {
        "username": username,
        "displayName": displayName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "uniqueId": uniqueId,
        "birthdate": birthdate.toIso8601String(),
        "gender": gender,
        "customGender": customGender,
        "asset": {
          "mimeType": "image/jpeg",
          "data": imageb64,
        },
        "fbUserId": fbid,
        'fbToken': fbToken,
        'fbAccessExpirationTime': fbexpires.toIso8601String(),
        "fbSignedRequest": "MOBILE",
      };
      //encode Map to JSON
      var body = jsonEncode(data);
      print(body);

      var responsepostRequest =
          await http.post(url, headers: headers, body: body);
      print("${responsepostRequest.statusCode}");
      print("${responsepostRequest.body}");
      final jsonResponse = jsonDecode(responsepostRequest.body);
      print('Registerbody${responsepostRequest.body}');
      msg = jsonResponse['message'];

      if (responsepostRequest.statusCode == 200) {
        mybody = jsonResponse["data"];

        if (jsonResponse['status'] == 1) {
          setState(() {
            print("Response status :${jsonResponse.statusCode}");
            print("Response status :${jsonResponse.body}");
            sharedPreferences.setString(
                "token", '${jsonResponse["data"]["token"]}');
            mytoken = jsonResponse["data"]["token"];
            isregisterfb = true;
          });
        }
      }
      if (jsonResponse.statusCode == 400) {
        if (jsonResponse['status'] == 0) {
          setState(() {
            isregisterfb = false;

            // _isloading = false;

            // iserror = true;
          });
        }
      }
      print('msg$msg');

      return responsepostRequest;
    } catch (e) {
      print(e.toString());
      setState(() {
        isclick = false;
      });
    }
  }

  Future<http.Response> checkuniqueId(
    String uniqueId,
  ) async {
    try {
      var url = Uri.parse("${Api.url}api/user/uniqueid/check");
      final headers = {
        "mode": "EMAIL",
        "content-type": "application/json",
      };

      Map data = {
        "uniqueId": uniqueId,
      };
      //encode Map to JSON
      var body = jsonEncode(data);
      print(body);

      var responsepostRequest =
          await http.post(url, headers: headers, body: body);
      print("${responsepostRequest.statusCode}");
      print("${responsepostRequest.body}");
      final jsonResponse = jsonDecode(responsepostRequest.body);
      print('Registerbody${responsepostRequest.body}');
      msg = jsonResponse['message'];

      if (responsepostRequest.statusCode == 200) {
        mybody = jsonResponse["data"];
        mybody1 = jsonResponse["error"];

        if (jsonResponse['status'] == 1) {
          setState(() {
            ischeckuniqueid = mybody;
          });
          print('ischeckuniqueid$ischeckuniqueid');
        }
        if (jsonResponse['status'] == 0) {
          if (msg == 'uniqueId can not use') {
            setState(() {
              msg = "ยูสเซอร์เนมถูกใช้งานแล้ว";
            });
          }
          setState(() {
            ischeckuniqueid = mybody1;
          });
          print('ischeckuniqueid$ischeckuniqueid');
        }
      }
      if (jsonResponse.statusCode == 400) {
        if (jsonResponse['status'] == 0) {
          setState(() {});
        }
      }

      return responsepostRequest;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(imageUrl);
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => MyApp()),
        //   );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(msg),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // if(ischeckuniqueid==false){
    //   return
    // }

    //--------------------ชื่อที่ต้องการแสดง----------------------//
    final TextFormField _txtNameProfild = TextFormField(
      controller: _name,
      decoration: InputDecoration(
        hintText: 'ชื่อที่ต้องการแสดง',
        contentPadding: EdgeInsets.only(left: 25, top: 10),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่ชื่อที่ต้องการแสดง';
        }
        return null;
      },
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
    //-------------------ยูสเซอร์เนม---------------------//
    final TextFormField _txtuniqueid = TextFormField(
      controller: _uniqueid,
      decoration: InputDecoration(
        hintText: '@ ยูสเซอร์เนม',
        contentPadding: EdgeInsets.only(left: 25, top: 10),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่ยูสเซอร์เนม';
        }

        return null;
      },
      onChanged: (value) async {
        await checkuniqueId(value);

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
        if (ischeckuniqueid == false) {
          return showAlertDialog(context);
        }
      },
    );
    //-------------------------ชื่อ-----------------------------//
    final TextFormField _txtfirstName = TextFormField(
      controller: _firstname,
      decoration: InputDecoration(
        hintText: 'ชื่อ',
        contentPadding: EdgeInsets.only(left: 25, top: 10),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่ชื่อ';
        }
        return null;
      },
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
    //--------------------นามสกุล----------------------//
    final TextFormField _txtlastName = TextFormField(
      controller: _lastname,
      decoration: InputDecoration(
        hintText: 'นามสกุล',
        contentPadding: EdgeInsets.only(left: 25, top: 10),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่นามสกุล';
        }
        return null;
      },
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
    //--------------------Email----------------------//
    final TextFormField _txtEmail = TextFormField(
      controller: _email,
      decoration: InputDecoration(
        hintText: 'อีเมล',
        contentPadding: EdgeInsets.only(left: 25, top: 10),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      readOnly: true,
    );
    final TextFormField _txtcustomGender = TextFormField(
      controller: _customGender,
      decoration: InputDecoration(
        hintText: 'อื่นๆ',
        contentPadding: EdgeInsets.only(left: 25, top: 10),
        border: InputBorder.none,
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      cursorColor: MColors.primaryColor,
      validator: (value) {
        if (value.isEmpty) {
          return 'กรุณาใส่';
        }
        return null;
      },
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
    //--------------------Birthday ----------------------//
    Widget _txtBirthday() {
      final f = new DateFormat('yyyy-MM-dd');
      return TextFormField(
        controller: _birthday,
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'วันเกิด',
          suffixIcon: InkWell(
              onTap: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2133, 3, 5),
                    maxTime: DateTime(2564, 6, 7),
                    theme: DatePickerTheme(
                      headerColor: Colors.white,
                      backgroundColor: Colors.white,
                      itemStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      doneStyle: TextStyle(color: Colors.black, fontSize: 16),
                      cancelStyle: TextStyle(color: Colors.black, fontSize: 16),
                    ),

                    //     onChanged: (date) {
                    //                         _birthday.text = f.format(date).toString();

                    //   print('change $date in time zone ' +
                    //       date.timeZoneOffset.inHours.toString());
                    // },
                    onConfirm: (date) {
                  date = date;

                  _birthday.text = f.format(date).toString();

                  print('confirm $date');
                }, currentTime: DateTime.now(), locale: LocaleType.th);
              },
              child: Icon(
                Icons.calendar_today,
                color: MColors.primaryColor,
              )),
          //Icon(Icons.calendar_today)
          contentPadding: EdgeInsets.only(left: 25, top: 15),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.text,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty) {
            return 'กรุณาใส่วันเกิด';
          }
          return null;
        },
      );
    }

    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/shutterstock_553511089.png'),
              fit: BoxFit.cover,
            )),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
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
                              image:
                                  AssetImage('images/MFP-Logo-Horizontal.png'),
                            )),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'โปรไฟล์\n',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              children: [
                                TextSpan(
                                    text: 'ข้อมูลทั่วไป',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey[300])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.86,
                    ),
                    //--------------------ชื่อที่ต้องการแสดง----------------------//
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 240, 240),
                          border: Border.all(width: 1.2, color: Colors.black12),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0))),
                      child: _txtNameProfild,
                    ),
                    //-------------------ยูสเซอร์เนม---------------------//
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 240, 240),
                          border: Border.all(
                              width: ischeckuniqueid == false ? 2.5 : 1.2,
                              color: ischeckuniqueid == false
                                  ? Colors.red
                                  : Colors.black12),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0))),
                      child: _txtuniqueid,
                    ),
                    Container(
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.86,
                    ),
                    Container(
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        children: [
                          Text('ข้อมูลส่วนตัว',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[300]))
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.86,
                    ),
                    //----------------------ชื่อ-------------------------//
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 240, 240),
                          border: Border.all(width: 1.2, color: Colors.black12),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0))),
                      child: _txtfirstName,
                    ),
                    //---------------------นามสกุล----------------------//
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 240, 240),
                          border: Border.all(width: 1.2, color: Colors.black12),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0))),
                      child: _txtlastName,
                    ),
                    //----------------------Emai----------------------//
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 240, 240),
                          border: Border.all(width: 1.2, color: Colors.black12),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0))),
                      child: _txtEmail,
                    ),
                    Container(
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.86,
                    ),
                    Container(
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        children: [
                          Text('อื่นๆ',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[300]))
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.86,
                    ),
                    //----------------------Birthday----------------------//
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 240, 240),
                          border: Border.all(width: 1.2, color: Colors.black12),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0))),
                      child: _txtBirthday(),
                    ),
                    //----------------------เพศกำหนดเอง----------------------//
                    Container(
                        height: 60,
                        width: 350,
                        margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            border:
                                Border.all(width: 1.2, color: Colors.black12),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: Icon(Icons.arrow_drop_down_outlined),
                            items: _genderType
                                .map((value) => DropdownMenuItem(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      value: value,
                                    ))
                                .toList(),
                            onChanged: (String value) {
                              setState(() {
                                _selectedValue = value;
                              });
                              print('value');
                              if (_selectedValue == "ผู้ชาย") {
                                setState(() {
                                  gendertypeint = 0;
                                });
                              }
                              if (_selectedValue == "ผู้หญิง") {
                                setState(() {
                                  gendertypeint = 1;
                                });
                              }
                              if (_selectedValue == "อื่นๆ") {
                                setState(() {
                                  gendertypeint = 3;
                                });
                              }
                              print(_selectedValue);
                              print(gendertypeint);
                            },
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                'โปรดระบุเพศ',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ),
                            value: _selectedValue,
                          ),
                        )),
                    gendertypeint == 3
                        ? Container(
                            height: 60,
                            margin:
                                EdgeInsets.only(top: 10, left: 30, right: 30),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 240, 240),
                                border: Border.all(
                                    width: 1.2, color: Colors.black12),
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0))),
                            child: _txtcustomGender,
                          )
                        : SizedBox.shrink(),
                    Container(
                      //color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.03,
                      width: MediaQuery.of(context).size.width * 0.86,
                    ),
                    _isButtonDisabled == true
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                      padding:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          side: BorderSide(color: Colors.red)),
                                      child: Text(
                                        'ถัดไป',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      textColor: Colors.white,
                                      color:
                                          MColors.primaryColor.withOpacity(0.5),
                                      onPressed: () {}),
                                )
                              ],
                            ),
                          )
                        : isclick == true
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: RaisedButton(
                                        padding: EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side:
                                                BorderSide(color: Colors.red)),
                                        child: CircularProgressIndicator(
                                          color: MColors.primaryColor,
                                        ),
                                        onPressed: null,
                                      ),
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
                                        padding: EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side:
                                                BorderSide(color: Colors.red)),
                                        child: Text(
                                          'ถัดไป',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        textColor: Colors.white,
                                        color: MColors.primaryColor,
                                        onPressed: ischeckuniqueid == false
                                            ? null
                                            : () async {
                                                _validateInputs();
                                                if (widget.mode == "FB") {
                                                  await fbregister(
                                                    _email.text,
                                                    widget.password,
                                                    _name.text,
                                                    _email.text,
                                                    _firstname.text,
                                                    _lastname.text,
                                                    '_uniqueid.text',
                                                    DateTime.parse(
                                                        _birthday.text),
                                                    gendertypeint,
                                                    gendertypeint == 3
                                                        ? _customGender.text
                                                        : "",
                                                    widget.img64,
                                                    widget.fbid,
                                                    widget.fbtoken,
                                                    DateTime.parse(widget
                                                        .fbexpires
                                                        .toString()),
                                                  );
                                                }
                                                if (widget.mode == "EMAIL") {
                                                  await Register(
                                                    _email.text,
                                                    widget.password,
                                                    _name.text,
                                                    _email.text,
                                                    _firstname.text,
                                                    _lastname.text,
                                                    _uniqueid.text,
                                                    DateTime.parse(
                                                        _birthday.text),
                                                    gendertypeint,
                                                    gendertypeint == 3
                                                        ? _customGender.text
                                                        : "",
                                                  );
                                                }
                                                print('isregister$isregister');
                                                print(
                                                    'isregisterfb$isregisterfb');
                                                if (isregisterfb == true) {
                                                  return Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          CupertinoPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  NavScreen()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                }

                                                //  showAlertDialog(context);

                                                isregister == true
                                                    ? Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Buildprofile(
                                                                  firstname:
                                                                      _firstname
                                                                          .text,
                                                                  lastname:
                                                                      _lastname
                                                                          .text,
                                                                  image: widget
                                                                      .fileimg,
                                                                  uniqueid:
                                                                      _uniqueid
                                                                          .text,
                                                                  email: widget
                                                                      .email,
                                                                  password: widget
                                                                      .password,
                                                                )),
                                                      )
                                                    : showAlertDialog(context);

                                                // print('กด');
                                              },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
