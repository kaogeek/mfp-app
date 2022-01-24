import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
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
import 'package:twitter_login/twitter_login.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  dynamic _userData;
  bool _checking = true;
  Map _userObj = {};
  // final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';

  var profileData;

  var msg = "";

  var userid;

  var mytoken;

  bool iserror;

  bool isfacebookLoggedIn = false;

  bool isTwitterLoggedIn = false;

  String prettyPrint(Map json) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  @override
  void initState() {
    Get.reset();

    super.initState();
  }

  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.of(context).pop();
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

  void initiateFacebookLogin() async {
    setState(() {
      isfacebookLoggedIn = true;
    });
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logIn(['public_profile', 'email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        // print("Error");
        setState(() {
          isfacebookLoggedIn = false;
        });
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        // print("CancelledByUser");
        setState(() {
          isfacebookLoggedIn = false;
        });
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = facebookLoginResult.accessToken;
        // print('''
        //  Logged in!

        //  Token: ${accessToken.token}
        //  User id: ${accessToken.userId}
        //  Expires: ${accessToken.expires}
        //  Permissions: ${accessToken.permissions}
        //  Declined permissions: ${accessToken.declinedPermissions}

        //  ''');

        // print("LoggedIn");

        var graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v10.0/me?access_token=${facebookLoginResult.accessToken.token}&fields=name,first_name,last_name,birthday,picture,email,gender&method=get&pretty=0&sdk=joey&suppress_http_code=1'));
        var profile = json.decode(graphResponse.body);
        // profileData.add(profile);
        // print(profile.toString());
        // print('Logged in as: ${profile['name']}');

        onLoginStatusChanged(true, profileData: profile);
        final imgBase64Str = await networkImageToBase64(
          profileData['picture']['data']['url'],
        );

        // print('name${profileData['name']}');
        // print('picture${profileData['picture']['data']['url']}');
        await singinfb(accessToken.token, accessToken, imgBase64Str,
            profileData: profile);

        break;
    }
  }

  void initiateFacebookTwitter() async {
    setState(() {
      isTwitterLoggedIn = true;
    });
    final twitterLogin = TwitterLogin(
      /// Consumer API keys
      apiKey: '',

      /// Consumer API Secret keys
      apiSecretKey: '',

      /// Registered Callback URLs in TwitterApp
      /// Android is a deeplink
      /// iOS is a URLScheme
      redirectURI: 'https://today.moveforwardparty.org/login',
    );

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);
    final authResult = await twitterLogin.login();
    var session = authResult.user;
    // print('''
    //      Logged inTw!

    //      name: ${session.name}
    //     email: ${session.email}
    //      authToken: ${authResult.authToken}

    //      ''');

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // print('''
        //  Logged inTw!

        //  name: ${session.name}
        // email: ${session.email}
        //  authToken: ${authResult.authToken}

        //  ''');

        // success
        // print('====== Login success ======');
        break;
      case TwitterLoginStatus.cancelledByUser:
        setState(() {
          isTwitterLoggedIn = false;
        });
        // cancel
        // print('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
        setState(() {
          isTwitterLoggedIn = false;
        });
        break;
      // case null:
      //   // error
      //   print('====== Login error ======');
      //   break;
    }
  }

  bool isLoggedIn = false;

  Future<http.Response> singinfb(
      String fbtoken, FacebookAccessToken accessToken, String imgBase64Str,
      {profileData}) async {
    // print('singinFB');
    setState(() {
      isLoggedIn = true;
    });
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
    // print(jsonResponse);

    if (res.statusCode == 200) {
      if (jsonResponse['status'] == 1) {
        // print(jsonResponse['message']);
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
          // print("myuid$userid");
          if (mytoken != null) {
            isLoggedIn = true;
          } else if (mytoken == null) {
            iserror = true;
            isLoggedIn = false;
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
        // print(jsonResponse['message']);
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
                builder: (BuildContext context) => Generalinformation(
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
                    isfb: false)),
            (Route<dynamic> route) => false);
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.grey[500], BlendMode.modulate),
            image: AssetImage('images/shutterstock_553511089.png'),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.18,
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
                            // print('กด');
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

                  //-------------------------------เข้าสู่ระบบด้วย Email-------------------------------//

                  //------------------------------เข้าสู่ระบบด้วย Twitter------------------------------//
                  _bution(
                    'เข้าสู่ระบบด้วย Email',
                    'images/Email.png',
                    Color(0xFFE5E5E5),
                    MColors.primaryBlue,
                    isfacebookLoggedIn != true
                        ? isTwitterLoggedIn != true
                            ? () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Loginemail()),
                                );
                              }
                            : null
                        : null,
                    Container(),
                  ),
                  _bution(
                    'เข้าสู่ระบบด้วย Facebook',
                    'images/facebook.png',
                    Color(0xFF1877F2),
                    Colors.white,
                    isfacebookLoggedIn != true
                        ? () async {
                            initiateFacebookLogin();
                            setState(() {
                              isfacebookLoggedIn = true;
                            });
                          }
                        : null,
                    isfacebookLoggedIn == false
                        ? Container()
                        : CircularProgressIndicator(
                            color: MColors.primaryColor,
                          ),
                  ),
                  _bution(
                    'เข้าสู่ระบบด้วย Twitter',
                    'images/twitter.png',
                    Color(0xFF1DA1F3),
                    Colors.white,
                    isfacebookLoggedIn != true ? () {} : null,
                    Container(),
                    //  isTwitterLoggedIn!=true   ?   isfacebookLoggedIn==false  ?()  async {
                    //                             initiateFacebookTwitter();
                    //        setState(() {
                    //     isTwitterLoggedIn = true;
                    //   });
                    //       }
                    //     : null: null,
                    // isTwitterLoggedIn != true  ? isTwitterLoggedIn!=true  ?Container():    CircularProgressIndicator(
                    //   color: MColors.primaryColor,
                    // ):    CircularProgressIndicator(
                    //   color: MColors.primaryColor,
                    // ),
                  ),
                  const SizedBox(
                    height: 10,
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
      Color textColor, Function onPressed, Widget widget) {
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
                  width: MediaQuery.of(context).size.width / 7,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(textassetimage),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.9,
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: AppTheme.FontAnakotmaiLight,
                    ),
                  ),
                ),
                Spacer(),
                widget,
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
