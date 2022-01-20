import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mfp_app/allWidget/allWidget.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/internetConnectivity.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:mfp_app/view/Auth/register_ginfo.dart';

class PicProfile extends StatefulWidget {
  final String email;

  final String password;
  PicProfile({
    Key key,
    @required this.email,
    @required this.password,
  }) : super(key: key);

  @override
  _PicProfileState createState() => _PicProfileState();
}

class _PicProfileState extends State<PicProfile> {
  File _image;
  String img64;
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

  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    setState(() {
      _image = image as File;
    });
  }

  Future getImage() async {
    //("getImage");
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      final bytes = File(image.path).readAsBytesSync();
      img64 = base64Encode(bytes);
    }
  }

  void _clear() {
    setState(() => _image = null);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        getImage();

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width ,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/shutterstock_553511089.png'),
                                colorFilter: ColorFilter.mode(Colors.grey[500], BlendMode.modulate),

        fit: BoxFit.cover,
      )),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                        //('กด');
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
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Center(
                      child: Text(
                    'อัพโหลดโปรไฟล์',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppTheme.FontAnakotmaiLight,
                    ),
                  ))),
              Container(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.86,
              ),
              _image != null
                  ? Container(
                      //-------------------รูปโปรไฟล์----------------//
                      //color: Colors.grey,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: CircleAvatar(
                        radius: (80),
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 108.0,
                          backgroundImage: FileImage(_image),
                        ),
                      ))
                  : Container(
                      //-------------------รูปโปรไฟล์----------------//
                      //color: Colors.grey,
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: CircleAvatar(
                        radius: (80),
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 108.0,
                          backgroundImage: AssetImage('images/placeholder.png'),
                        ),
                      )),
              Container(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.86,
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
                          'ถ่ายภาพ',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppTheme.FontAnakotmaiLight,
                          ),
                        ),
                        textColor: Colors.white,
                        color: MColors.primaryColor,
                        onPressed: () {
                          _imgFromCamera();
                          // Navigator.of(context).pop();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Upprofile()),
                          // );
                          //('กด');
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.02,
                width: MediaQuery.of(context).size.width * 0.86,
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
                          'เลือกรูปภาพ',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppTheme.FontAnakotmaiLight,
                          ),
                        ),
                        textColor: Colors.white,
                        color: MColors.primaryColor,
                        onPressed: () {
                          getImage();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Upprofile()),
                          // );
                          //('กด');
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                //color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.02,
                width: MediaQuery.of(context).size.width * 0.86,
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
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppTheme.FontAnakotmaiLight,
                          ),
                        ),
                        textColor: Colors.white,
                        color: MColors.primaryColor.withOpacity(0.1),
                        onPressed: () {
                          if (_image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: MColors.primaryWhite,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('กรุณาใส่รูป')
                                ],
                              ),
                              duration: const Duration(milliseconds: 500),
                            ));
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Generalinformation(
                                        email: widget.email,
                                        password: widget.password,
                                        img64: img64,
                                        fileimg: _image,
                                        mode: "EMAIL",
                                        isfb: true,
                                      )),
                            );
                          }

                          //('กด');
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                //color: Colors.black,
                alignment: Alignment.bottomCenter,
                child: Text(
                  '© 2021 พรรคก้าวไกล. ALL RIGHTS RESERVED.',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
