import 'dart:convert';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:mfp_app/model/RecommendedUserPageModel.dart';
import 'package:mfp_app/model/postModel.dart';
import 'package:mfp_app/model/searchhastag.dart';
import 'package:mfp_app/model/searchpostlist.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as Http;

class Api {
  static const String url = "https://today-api.moveforwardparty.org/";

  static Future logout() async {
    var facebookLogin = FacebookLogin();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await SharedPreferences.getInstance();
    await preferences.remove("token");
    await preferences.remove("userid");
    await preferences.remove("mode");

    var clear = await preferences.clear();
    await facebookLogin.logOut();

    // preferences?.setBool("isLoggedIn", false);
    // preferences?.setString("token", "");
    // preferences?.setString("imageURL", "");
    // print("!remover secc");

    // return clear;
  }
  /*--------------------logout--------------------------------------*/

  static Future<Http.Response> getuserprofile(String userid) async {
    // print('getuserprofile');

    final responseData = await Http.get("${Api.url}api/profile/$userid");

    return responseData;
  }

  /*--------------------ดึงค่าuserprofile--------------------------------------*/
  static Future<Http.Response> getPage(String pageid) async {
    // print('getPage');

    final responseData = await Http.get("${Api.url}api/page/$pageid");

    return responseData;
  }

  static Future gettoke() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenname = prefs.getString('token');
    return tokenname;
  }
  /*--------------------gettokeจากSharedPreferences--------------------------------------*/

  static Future getmyuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myuid = prefs.getString('myuid');
    return myuid;
  }
  /*--------------------getmyuidจากSharedPreferences--------------------------------------*/

  static Future getimageURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var imageURL = prefs.getString('imageURL');
    return imageURL;
  }

  /*--------------------getimageURLจากSharedPreferences--------------------------------------*/
  static Future getmodelogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mode = prefs.getString('mode');
    return mode;
  }

  static Future getPostList(int offset) async {
    // print('getPostList');
    String url = "${Api.url}api/main/content/search";
    final headers = {
      // "mode": "EMAIL",
      "authority": "today-api.moveforwardparty.org",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": [""],
      "hashtag": [""],
      "type": "",
      "createBy": [],
      "objective": "",
      "endActionCount": 16,
      "pageCategories": [],
      "sortBy": "LASTEST_DATE",
      "filter": {"limit": 5, "offset": offset}
    };
    var body = jsonEncode(data);
    print(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print(responseData.body);

    return responseData;
  }

  //---------------
  static Future<List<PostSearchModel>> getpostlisttest(int offset) async {
    // print('getPostList');
    List<PostSearchModel> postlist = [];

    String url = "${Api.url}api/main/content/search?isHideStory=true";
    final headers = {
      // "mode": "EMAIL",
      "authority": "today-api.moveforwardparty.org",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": [""],
      "hashtag": [""],
      "type": "",
      "createBy": [],
      "objective": "",
      "endActionCount": 16,
      "pageCategories": [],
      "sortBy": "LASTEST_DATE",
      "filter": {"limit": 5, "offset": offset}
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );

    if (responseData.statusCode == 200) {
      var datapostlist = jsonDecode(responseData.body);
      for (Map i in datapostlist["data"]) {
        postlist.add(PostSearchModel.fromJson(i));
      }
      return postlist;
    } else if (responseData.statusCode == 400) {
      return null;
    }
  }

  /*--------------------getPostจาก/content/search--------------------------------------*/

  static Future getemergencycontent(String emergencyEventId) async {
    final responseData =
        await Http.get("${Api.url}api/emergency/$emergencyEventId/timeline");

    return responseData;
  }
  /*--------------------getcontentemergencyจาก/emergency/emergencyid/timeline--------------------------------------*/

  static Future<List<RecomUserPageModel>> getRecommendedUserPage() async {
    List<RecomUserPageModel> pagelist = [];

    final responseData =
        await Http.get("${Api.url}api/recommend?limit=5&offset=0");
    if (responseData.statusCode == 200) {
      var data = jsonDecode(responseData.body);
      for (Map i in data["data"]) {
        pagelist.add(RecomUserPageModel.fromJson(i));
      }
      return pagelist;
    } else if (responseData.statusCode == 200) {
      return null;
    }
  }

  static Future singin(String email, String pass) async {
    print('singin');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var mytoken;
    bool islogin = false;
    var url = Uri.parse("${Api.url}api/login");
    Map data = {"username": email, "password": pass};
    final headers = {
      "mode": "EMAIL",
      "content-type": "application/json",
    };
    var body = jsonEncode(data);

    var res = await Http.post(url, headers: headers, body: body);

    return res;
  }

  static Future getstory(String id) async {
    var storytestreplaceAll, storytest;
    try {
      var url = Uri.parse("${Api.url}api/post/search");
      final headers = {
        "content-type": "application/json",
      };
      Map data = {
        "limit": 10,
        "count": false,
        "whereConditions": {"_id": id}
      };
      var body = jsonEncode(data);
      var responseRequest = await Http.post(url, headers: headers, body: body);
      return responseRequest;
     
    } catch (e) {}
  }

  /*--------------------getแนะนำpageUseryจาก/recommend--------------------------------------*/
  static Future<Http.Response> sendfollowPage(
      String pageid, String token, String userid) async {
    // print('getHashtagList');
    var url = "${Api.url}api/page/$pageid/follow";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
      "authorization": "Bearer $token",
      "userid": userid
    };
    Map data = {};
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('headers$headers');
    // print('responseData${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> getHashtagData() async {
    // print('getData');

    final responseData = await Http.get(
        "${Api.url}api/main/content");

    return responseData;
  }

  static Future<Http.Response> getHashtagList() async {
    // print('getHashtagList');
    var url = "${Api.url}api/hashtag/trend/";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "filter": {
        "limit": 4,
        "offset": 0,
        "relation": [],
        "whereConditions": {},
        "count": false,
        "orderBy": {}
      }
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('responseData${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> getProfileSS() async {
    var url = "https://today-api.moveforwardparty.org/api/page/search";

    Map data = {
      "limit": 10,
      "count": false,
      "isOfficial": true,
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(url, body: body);

    return responseData;
  }

  // static Future<Http.Response> getPostList() async {
  //   print('getHashtagList');
  //   final responseData = await Http.get(
  //       "https://today-api.moveforwardparty.org/api/main/content");

  //   return responseData;
  // }

  static Future<List<EmergencyEventsContent>>
      getPostemergencyEventsList() async {
    List<EmergencyEventsContent> listemergencyEvents = [];
    // print('getHashtagList');
    final responseData = await Http.get(
        "${Api.url}api/main/content");
    if (responseData.statusCode == 200) {
      var datapostlist = jsonDecode(responseData.body);
      for (Map i in datapostlist["data"]["emergencyEvents"]["contents"]) {
        listemergencyEvents.add(EmergencyEventsContent.fromJson(i));
      }
      return listemergencyEvents;
    } else if (responseData.statusCode == 400) {
      return null;
    }
  }

  static Future<Http.Response> getPostsectionModelsEventsList() async {
    // print('getHashtagList');
    final responseData = await Http.get(
        "${Api.url}api/main/content");
    // print(responseData.body);

    return responseData;
  }

  static Future<Http.Response> getPostDetailSS(String id) async {
    // print('getPostDetailSS');

    final responseData = await Http.get(
        "${Api.url}api/page/$id/post/?offset=0");

    return responseData;
  }

  static Future<List<SearchHastag>> getHt(String query) async {
    // print('getHashtagList');
    var url = "${Api.url}api/hashtag/trend/";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "filter": {
        "limit": 4,
        "offset": 0,
        "relation": [],
        "whereConditions": {},
        "count": false,
        "orderBy": {}
      }
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    if (responseData.statusCode == 200) {
      final List ht = json.decode(responseData.body);

      return ht.map((json) => SearchHastag.fromJson(json)).where((book) {
        final titleLower = book.label.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<Http.Response> mantsearch(String quer) async {
    // print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/main/search/";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": quer,
      "user": "6bf3212e-ae4b-4ca3-3702-41316afefa2e",
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('responseData${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> mantinitisearch(String uid) async {
    // print('getHashtagList');
    var url = "${Api.url}api/hashtag/trend/";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      // "keyword": "",
      // "user": "60c9cc216923656607919f06",
      "filter": {
        "limit": 10,
        "offset": 0,
        "relation": [],
        "whereConditions": {},
        "count": false,
        "orderBy": {}
      },
      "userId": uid
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('responseData${responseData.body}');

    return responseData;
  }

  static Future apisearchlist(
      String keyword, String hashtag, int offset) async {
    List<SearchPostList> searchpostList = [];

    // print('getHashtagList');
    var url = "${Api.url}api/main/content/search";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": [keyword],
      "hashtag": [hashtag],
      "type": "",
      "createBy": [],
      "objective": "",
      "pageCategories": [],
      "sortBy": "LASTEST_DATE",
      "filter": {"limit": 5, "offset": offset}
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('responseData${responseData.body}');

    if (responseData.statusCode == 200) {
      var datapostlist = jsonDecode(responseData.body);
      for (Map i in datapostlist["data"]) {
        searchpostList.add(SearchPostList.fromJson(i));
      }
      return searchpostList;
    } else if (responseData.statusCode == 400) {
      return null;
    }
  }

  static Future<Http.Response> getcommentlist(
      String postid, String uid, String token) async {
    // print('getcommentlist');

    var url = "${Api.url}api/post/$postid/comment/search";
    final headers = {
      "userid": uid,
      "content-type": "application/json",
      "authorization": token,
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {
      "limit": 5,
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('responseDatacommentlist${responseData.body}');

    return responseData;
  }

  //  static Future<Http.Response> sendcomment(String postid) async {
  //   print('sendcomment');
  //   var url = "https://today-api.moveforwardparty.org/api/post/$postid/comment";
  //   final headers = {
  //     "userid": "60c9cc216923656607919f06",
  //           "content-type":"application/json",
  //           "accept":"application/json"
  //     // "whereConditions": {"isHideStory": false},
  //   };
  //   Map data = {
  //    "commentAsPage":"60c9cc216923656607919f06",
  //    "comment":"testsend"
  //   };
  //   var body = jsonEncode(data);

  //   final responseData = await Http.post(
  //     url,
  //     headers: headers,
  //     body: body,
  //   );
  //   print('body$body');
  //   print('responseDatacommentlist${responseData.body}');

  //   return responseData;
  // }

  static Future<Http.Response> updataimage(
      String id, String base64image, String fileName, String token) async {
    // print('updataimage');
    var url = "${Api.url}api/profile/$id/image";
    final headers = {
      "userid": id,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {
      "asset": {
        "mimeType": "image/png",
        "data": base64image,
        "fileName": fileName,
        "size": 193148
      }
    };

    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('responseupdataimage${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> repost(
      String postid, String uid, String token) async {
    // print('repost');
    var url = "${Api.url}api/post/$postid/repost";
    final headers = {
      "userid": uid,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {"pageId": null};

    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('repost${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> repostwithdetail(
      String postid, String uid, String token, String detail) async {
    // print('repostwithdetail');
    var url = "${Api.url}api/post/$postid/repost";
    final headers = {
      "userid": uid,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {"pageId": null, "detail": detail};

    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('repost${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> islike(
      String postid, String uid, String token, String mode) async {
    // print('sendcomment');
    var url = "${Api.url}api/post/$postid/like";
    final headers = {
      "userid": uid,
      "mode": mode,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {
      //  "asset":
      //  {"mimeType":"image/png",
      //  "data":base64image,
      //  "fileName":fileName,
      //  "size":193148}
    };

    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('islike${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> isfollowpage(
      String pageid, String uid, String token) async {
    var url = "${Api.url}api/page/$pageid/follow";
    final headers = {
      "userid": uid,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {};

    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('islike${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> islikecomment(
      String postid, String uid, String token, String commentid,String mode) async {
    // print('islikecomment');
    var url = "${Api.url}api/post/$postid/comment/$commentid/like";
    final headers = {
      "userid": uid,
      "mode":mode,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {};

    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('headers$headers');

    // print('islikecomment${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> iseditcomment(String postid, String uid,
      String token, String commentid, String commenttext) async {
    // print('iseditcomment');
    var url =
        "${Api.url}api/post/$postid/comment/$commentid";
    final headers = {
      "userid": uid,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {"comment": commenttext};

    var body = jsonEncode(data);

    final responseData = await Http.put(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('iseditcomment${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> isfollow(
      String postid, String uid, String token, String pageid) async {
    // print('isfollow');
    var url = "${Api.url}api/page/$pageid/follow";
    final headers = {
      "userid": uid,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {};

    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('isfollow${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> getprofilepost(String uid, String token) async {
    // print('getprofilepost$uid');
    var url =
        "${Api.url}api/profile/$uid/post/search";
    final headers = {
      "authorization": "Bearer $token",
      "userid": uid,
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {"type": "", "offset": 0, "limit": 5};
    var body = jsonEncode(data);
    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    return responseData;
  }

  static Future<Http.Response> postsearch(
      String uid, String token, String postid,String mode) async {
    var url = "${Api.url}api/post/search";
    final headers = {
      "authorization": "Bearer $token",
      "userid": uid,
      "mode":mode,
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {
      "limit": 10,
      "count": false,
      "whereConditions": {"_id": postid}
    };
    var body = jsonEncode(data);
    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('getpostsearch1${responseData.body}');
    return responseData;
  }

  static Future<Http.Response> getpagess(
      String userid, String token, String pageid) async {
    // print('getpagess$userid');
    final headers = {
      // "Authorization": "Bearer $token",
      "userId": userid,
      "Content-Type": "application/json",
      // "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };

    final responseData = await Http.get(
        "${Api.url}api/page/$pageid",
        headers: headers);
    print('responseDatagetpagess${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> setimagecover(
      String uid, String base64image, String fileName, String token) async {
    // print('updataimage');
    var url = "${Api.url}api/profile/$uid/cover";
    final headers = {
      "userid": uid,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {
      "asset": {
        "mimeType": "image/png",
        "data": base64image,
        "fileName": fileName,
        "size": 193148
      }
    };

    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('responseupdataimage${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> createpost(
      String uid, String token, String title, String detail) async {
    // print('createpost');
    var url = "${Api.url}api/page/null/post";
    final headers = {
      "userid": uid,
      "authorization": "Bearer $token",
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {
      "title": "test",
      "detail": "test",
      "emergencyEvent": "",
      "emergencyEventTag": "",
      "userTags": [],
      "postsHashTags": [],
      "postGallery": [],
      "postSocialTW": false,
      "postSocialFB": false
    };

    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    // print('body$body');
    // print('repost${responseData.body}');

    return responseData;
  }
 static Future deletecomment(
      String postid, String mytoken, String commentid, String myuid,String mode) async {
    print('sendcomment');

    var url =
        "${Api.url}api/post/$postid/comment/$commentid";
    final headers = {
      "userid": myuid,
      "mode":mode,
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": "Bearer $mytoken",
    };

    final responseData = await Http.delete(
      url,
      headers: headers,
    );
    print('responseDatacommentlist${responseData.body}');
    final jsonResponse = jsonDecode(responseData.body);
    if (responseData.statusCode == 200) {
      print(jsonResponse['status']);
      if (jsonResponse['status'] == 1) {
      }
      print("deletecomment สำเร็จ");
    return jsonResponse;
  }
      }
}
