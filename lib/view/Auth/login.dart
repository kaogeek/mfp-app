import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/allWidget/sizeconfig.dart';
import 'package:mfp_app/constants/colors.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/utils/router.dart';
import 'package:http/http.dart' as http;
import 'package:mfp_app/view/Auth/loginemail.dart';
import 'package:mfp_app/view/Auth/register_ginfo.dart';
import 'package:mfp_app/view/NavigationBar/nav_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  dynamic _userData;
  bool _checking = true;
  bool _isLoggedIn = false;
  Map _userObj = {};
  final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';

  var profileData;

  var msg = "";

  var userid;

  var mytoken;

  bool iserror;

  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(imageUrl);
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logIn(['public_profile', 'email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = facebookLoginResult.accessToken;
        print(
            '''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}

         ''');

        print("LoggedIn");

        var graphResponse = await http.get(
            'https://graph.facebook.com/v10.0/me?access_token=${facebookLoginResult.accessToken.token}&fields=name,first_name,last_name,birthday,picture,email,gender&method=get&pretty=0&sdk=joey&suppress_http_code=1');
        var profile = json.decode(graphResponse.body);
        // profileData.add(profile);
        print(profile.toString());
        print('Logged in as: ${profile['name']}');

        onLoginStatusChanged(true, profileData: profile);
        final imgBase64Str = await networkImageToBase64(
          profileData['picture']['data']['url'],
        );

        print('name${profileData['name']}');
        print('picture${profileData['picture']['data']['url']}');
        await singinfb(accessToken.token, accessToken, imgBase64Str,
            profileData: profile);

        break;
    }
  }

  bool isLoggedIn = false;

  Future<http.Response> singinfb(
      String fbtoken, FacebookAccessToken accessToken, String imgBase64Str,
      {profileData}) async {
    print('singinFB');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var url = Uri.parse("${Api.url}api/login");
    Map data = {"token": fbtoken};
    final headers = {
      "mode": "FACEBOOK",
      "content-type": "application/json",
    };
    var body = jsonEncode(data);

    var res = await http.post(url, headers: headers, body: body);
    final jsonResponse = jsonDecode(res.body);
    print(jsonResponse);

    if (res.statusCode == 200) {
      if (jsonResponse['status'] == 1) {
        print(jsonResponse['message']);
        msg = jsonResponse['message'];
        if (jsonResponse != null) {
          sharedPreferences.setString(
              "token", '${jsonResponse["data"]["token"]}');
          sharedPreferences.setString(
              "myuid", '${jsonResponse["data"]["user"]["id"]}');
          sharedPreferences.setString(
              "imageURL", '${jsonResponse["data"]["user"]["imageURL"]}');
          sharedPreferences.setString("mode", 'FB');

          sharedPreferences?.setBool("isLoggedIn", true);
          mytoken = jsonResponse["data"]["token"];
          userid = jsonResponse["data"]["user"]["id"];
          print("myuid$userid");

          if (mytoken != null) {
            isLoggedIn = true;
          } else if (mytoken == null) {
            iserror = true;
          }

          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (BuildContext context) => NavScreen()),
              (Route<dynamic> route) => false);
        } else {
          setState(() {
            // _isloading = false;
          });
        }
      }
    }
    if (res.statusCode == 400) {
      if (jsonResponse['status'] == 0) {
        print(jsonResponse['message']);
        Navigate.pushPage(
            context,
            Generalinformation(
              email: profileData['email'],
              password: "",
              img64: imgBase64Str,
              name: profileData['name'],
              firstname: profileData['first_name'],
              lastname: profileData['last_name'],
              fbid: profileData['id'],
              fbtoken: accessToken.token,
              mode: 'FB',
              fbexpires: accessToken.expires,
            ));
        // setState(() {
        //   msg = jsonResponse['message'];
        //   // _isloading = false;

        //   iserror = true;
        // });
      }
    }
  }

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  //  Future<Null> _login() async {

  //   final FacebookLoginResult result =
  //       await facebookSignIn.logIn(['email']);

  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final FacebookAccessToken accessToken = result.accessToken;
  //       print('''
  //        Logged in!

  //        Token: ${accessToken.token}
  //        User id: ${accessToken.userId}
  //        Expires: ${accessToken.expires}
  //        Permissions: ${accessToken.permissions}
  //        Declined permissions: ${accessToken.declinedPermissions}
  //        ''');
  //          var graphResponse = await http.get(
  // 'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult
  // .accessToken.token}');

  // var profile = json.decode(graphResponse.body);
  // print(profile.toString());

  // // onLoginStatusChanged(true, profileData: profile);
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       _showMessage('Login cancelled by the user.');
  //       break;
  //     case FacebookLoginStatus.error:
  //       _showMessage('Something went wrong with the login process.\n'
  //           'Here\'s the error Facebook gave us: ${result.errorMessage}');
  //       break;
  //   }
  // }
  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenhight = MediaQuery.of(context).size.height;
    final screentop = MediaQuery.of(context).padding;

    return Container(
      color: MColors.primaryWhite,
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
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Column(
                children: <Widget>[
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
                  SizedBox(
                    height: SizeConfig.screenHeight / 9.0,
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          "เราอยากให้ทุกคนมี",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontFamily: AppTheme.FontAnakotmaiLight,
                              fontSize: 25,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        "เสรีภาพ เสมอภาค ภราดรภาพ",
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: AppTheme.FontAnakotmaiLight,
                            fontSize: 25,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenhight / 6.0,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Text(
                              'เข้าสู่ระบบด้วย',
                              style: TextStyle(
                                  fontFamily: AppTheme.FontAnakotmaiLight,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // SizedBox(
                  //   height: SizeConfig.screenHeight * 0.11,
                  // ),

                  //-------------------------------เข้าสู่ระบบด้วย Email-------------------------------//

                  //------------------------------เข้าสู่ระบบด้วย Twitter------------------------------//
                  _bution(
                    'เข้าสู่ระบบด้วยEmail',
                    'images/Email.png',
                    Color(0xFFE5E5E5),
                    MColors.primaryBlue,
                    () async {
                      // initiateFacebookLogin();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginemail()),
                      );
                    },
                  ),
                  _bution(
                    'เข้าสู่ระบบด้วยFacebook',
                    'images/facebook.png',
                    Color(0xFF1877F2),
                    Colors.white,
                    () async {
                      initiateFacebookLogin();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => widget),
                      // );
                    },
                  ),
                  _bution(
                    'เข้าสู่ระบบด้วยTwitter',
                    'images/twitter.png',
                    Color(0xFF1DA1F3),
                    Colors.white,
                    () async {
                      FacebookAuth.instance
                          .login(permissions: ["public_profile", "email"]).then(
                              (value) {
                        FacebookAuth.instance.getUserData().then((userData) {
                          setState(() {
                            _isLoggedIn = true;
                            _userObj = userData;
                          });
                        });
                        FacebookAuth.instance.expressLogin();
                        print(_userObj['name']);
                      });
                    },
                  ),

                  Container(
                    //color: Colors.black,
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
      ),
    );
  }

  Widget _bution(String text, String textassetimage, Color color,
      Color textColor, Function onPressed) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              children: [
                Container(
                  height: SizeConfig.screenHeight / 13.0,
                  width: SizeConfig.screenWidth / 7,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(textassetimage),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  text,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: AppTheme.FontAnakotmaiLight,
                  ),
                ),
              ],
            ),
            textColor: textColor,
            color: color,
            onPressed: onPressed,
          ),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.09,
        ),
      ],
    );
  }
}
