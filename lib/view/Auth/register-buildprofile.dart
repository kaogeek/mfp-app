import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Buildprofile extends StatefulWidget {
  final String firstname;
  final String email;
  final String password;

  final String lastname;
  final String uniqueid;

  final String img64;
  final File image;

  Buildprofile(
      {Key key,
      this.firstname,
      this.lastname,
      this.img64,
      this.image,
      this.uniqueid,
      this.email,
      this.password})
      : super(key: key);

  @override
  _BuildprofileState createState() => _BuildprofileState();
}

class _BuildprofileState extends State<Buildprofile> {
  var msg;

  var msgres;
  bool isloading =false;

  Future<http.Response> singin(String email, String pass) async {
    print('singin');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var url =Uri.parse( "${Api.url}api/login");
    Map data = {"username": email, "password": pass};
    final headers = {
      "mode": "EMAIL",
      "content-type": "application/json",
    };
    var body = jsonEncode(data);

    var res = await http.post(url, headers: headers, body: body);
    final jsonResponse = jsonDecode(res.body);

    if (res.statusCode == 200) {
      if (jsonResponse['status'] == 1) {
        print(jsonResponse['message']);
        msgres = jsonResponse['message'];
        if (jsonResponse != null) {
          sharedPreferences.setString(
              "token", '${jsonResponse["data"]["token"]}');
          sharedPreferences.setString(
              "myuid", '${jsonResponse["data"]["user"]["id"]}');

          sharedPreferences?.setBool("isLoggedIn", true);
          var mytoken = jsonResponse["data"]["token"];
          var userid = jsonResponse["data"]["user"]["id"];
          print("myuid$userid");
          await getImage(widget.image, userid, mytoken);
          sharedPreferences.setString(
              "imageURL", '${jsonResponse["data"]["user"]["imageURL"]}');
          if (mytoken != null) {
            isloading = true;
          } else if (mytoken == null) {
            // iserror = true;
          }

          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (BuildContext context) => NavScreen()),
              (Route<dynamic> route) => false);
        } else {
          setState(() {
           isloading = false;
          });
        }
      }
    }
    if (res.statusCode == 400) {
      if (jsonResponse['status'] == 0) {
        print(jsonResponse['message']);
        setState(() {
          // msgres = jsonResponse['message'];
          // _isloading = false;

          // iserror = true;
        });
      }
    }
  }

  Future getImage(File _image, String userid, String token) async {
    print("getImage");

    final bytes = _image.readAsBytesSync();

    String img64 = base64Encode(bytes);
    print(img64);
    var responseProfileImage =
        await Api.updataimage(userid, img64, "basic-ios.png", token);

    if (responseProfileImage != null &&
        responseProfileImage.statusCode == 200) {
      final jsonResponse = jsonDecode(responseProfileImage.body);

      if (jsonResponse['status'] == 1) {
        // _clear();

        // print(jsonResponse['message']);
        setState(() {
          msg = jsonResponse['message'];

          print('msg$msg');

          // iserror = true;
        });
      }
    }
    // showMessage('Profile Image not uploaded', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/shutterstock_553511089.png'),
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
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.86,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Confirmproduct()),
                    // );
                    print("กด");
                  },
                  child: Container(
                      //-------------------รูปโปรไฟล์----------------//
                      //color: Colors.grey,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: CircleAvatar(
                        radius: (80),
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 108.0,
                          backgroundImage: FileImage(widget.image),
                        ),
                      )),
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.02,
                  width: MediaQuery.of(context).size.width * 0.86,
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Center(
                      child: Text(
                    '${widget.firstname} ${widget.lastname}',
                    style: TextStyle(
                       fontSize: AppTheme.BodyTextSize20,
                            fontFamily: AppTheme.FontAnakotmaiMedium,
                     color: Colors.white),
                  )),
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Center(
                      child: Text(
                    '@${widget.uniqueid}',
                    style: TextStyle(
                     fontSize: AppTheme.BodyTextSize20,
                            fontFamily: AppTheme.FontAnakotmaiLight,
                            fontWeight: FontWeight.w300,
                    color: Colors.white
                    ),
                  )),
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.01,
                  width: MediaQuery.of(context).size.width * 0.86,
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Center(
                      child: Text('ยินดีต้อนรับสู่ พรรคก้าวไกล',
                          style: TextStyle(
                              fontSize: 27,
                            fontFamily: AppTheme.FontAnakotmaiBold,
                              color: Colors.white,
                              ))),
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.01,
                  width: MediaQuery.of(context).size.width * 0.86,
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Center(
                      child: Text('ยินดีต้อนรับสู่ แพลตฟอร์ม',
                          style: TextStyle(
                           fontSize: AppTheme.BodyTextSize20,
                            fontFamily: AppTheme.FontAnakotmaiMedium,
                          color: Colors.grey
                          ))),
                ),
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: Center(
                      child: Text('ก้าวไกลทูเดย์',
                          style: TextStyle(
                           fontSize: AppTheme.BodyTextSize20,
                            fontFamily: AppTheme.FontAnakotmaiMedium,
                          color: Colors.grey
                          ))),
                ),
                Container(
                  //color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.86,
                ),
                // isloading == true
                //             ? Container(
                  // width: MediaQuery.of(context).size.width * 0.9,
                //                 child: Row(
                //                   children: <Widget>[
                //                     Expanded(
                //                       child: ElevatedButton(
                //                         style: TextButton.styleFrom(
                //                           padding: EdgeInsets.only(
                //                               top: 15, bottom: 15),
                //                           shape: RoundedRectangleBorder(
                //                               borderRadius:
                //                                   BorderRadius.circular(30.0),
                //                               side: BorderSide(
                //                                   color: Colors.red)),
                //                           primary: MColors.primaryColor,
                //                         ),
                //                         onPressed: null,
                //                         child: Center(
                //                           child: CircularProgressIndicator(color: MColors.primaryColor,),
                //                         ),
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //               )
                //             :
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
                            'สร้างโปรไฟล์',
                            style: TextStyle(fontSize: AppTheme.BodyTextSize20,
                            fontFamily: AppTheme.FontAnakotmaiMedium,
                            ),
                          ),
                          textColor: Colors.white,
                          color: MColors.primaryColor,
                          onPressed: () async {
                            await singin(widget.email, widget.password);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Buildprofile()),
                            // );
                            print('กด');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
