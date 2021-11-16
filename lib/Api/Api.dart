import 'dart:convert';
import 'package:mfp_app/model/postlistSSmodel.dart';
import 'package:mfp_app/model/searchhastag.dart';
import 'package:flutter/foundation.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as Http;

class Api {
  static const String url = "https://today-api.moveforwardparty.org/";

  static Future logout() async {
    print('Calllogout');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await SharedPreferences.getInstance();
    await preferences.remove("token");
    var clear = await preferences.clear();
    preferences?.setBool("isLoggedIn", false);
    preferences?.setString("token", "");
    preferences?.setString("imageURL", "");
    print("!remover secc");
    return clear;
  }

  static Future<Http.Response> getuserprofile(String userid) async {
    print('getuserprofile');

    final responseData = await Http.get("${Api.url}api/profile/$userid");

    return responseData;
  }

  static Future gettoke() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenname = prefs.getString('token');
    return tokenname;
  }

  static Future getmyuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myuid = prefs.getString('myuid');
    return myuid;
  }

  static Future getimageURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var imageURL = prefs.getString('imageURL');
    return imageURL;
  }

  static Future getPostList(int offset) async {
    print('getPostList');
    String url = "${Api.url}api/main/content/search";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": [""],
      "hashtag": [""],
      "type": "",
      "createBy": [],
      "objective": "",
      "endActionCount": 6,
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
      return responseData;
    }
  }

  static Future getemergencycontent(String emergencyEventId) async {
    final responseData =
        await Http.get("${Api.url}api/emergency/$emergencyEventId/timeline");

    return responseData;
  }

  static Future<Http.Response> getRecommendedUserPage() async {
    final responseData =
        await Http.get("${Api.url}api/recommend?limit=5&offset=0");

    return responseData;
  }

  static Future<Http.Response> getHashtagData() async {
    // print('getData');

    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/main/content");

    return responseData;
  }

  static Future<Http.Response> getHashtagList() async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/hashtag/trend/";
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
    print('body$body');
    print('responseData${responseData.body}');

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

  static Future<Http.Response> getPostemergencyEventsList() async {
    print('getHashtagList');
    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/main/content");

    return responseData;
  }

  static Future<Http.Response> getPostsectionModelsEventsList() async {
    print('getHashtagList');
    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/main/content");
    print(responseData.body);

    return responseData;
  }

  static List<PostListSS> parsePost(String responseBody) {
    var list = jsonDecode(responseBody) as List<dynamic>;
    List<PostListSS> postlist =
        list.map((model) => PostListSS.fromJson(model)).toList();
    return postlist;
  }

  static Future<List<PostListSS>> getPostListSS1(String idss,
      {int page = 1}) async {
    print('getPostListSS1');
    final headers = {
      "limit": 1,
      "count": false,
      "whereConditions": {"isHideStory": false}
    };
    // print('getData');

    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/page/$idss/post/?offset=$page&limit=5");
    if (responseData.statusCode == 200) {
      return compute(parsePost, responseData.body);
    } else if (responseData.statusCode == 404) {
      throw Exception('Not Found');
    }
  }

  static Future<Http.Response> getPostDetailSS(String id) async {
    print('getPostDetailSS');

    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/page/$id/post/?offset=0");

    return responseData;
  }

  static Future<List<SearchHastag>> getHt(String query) async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/hashtag/trend/";
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
    print('getHashtagList');
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
    print('body$body');
    print('responseData${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> mantinitisearch(String uid) async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/hashtag/trend/";
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
    print('body$body');
    print('responseData${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> apisearchlist(
      String keyword, String hashtag, int offset) async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/main/content/search";
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
    print('body$body');
    print('responseData${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> getcommentlist(
      String postid, String uid, String token) async {
    print('getcommentlist');

    var url =
        "${Api.url}api/post/$postid/comment/search";
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
    print('body$body');
    print('responseDatacommentlist${responseData.body}');

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
    print('updataimage');
    var url = "https://today-api.moveforwardparty.org/api/profile/$id/image";
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
    print('body$body');
    print('responseupdataimage${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> repost(
      String postid, String uid, String token) async {
    print('repost');
    var url = "https://today-api.moveforwardparty.org/api/post/$postid/repost";
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
    print('body$body');
    print('repost${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> repostwithdetail(
      String postid, String uid, String token, String detail) async {
    print('repostwithdetail');
    var url = "https://today-api.moveforwardparty.org/api/post/$postid/repost";
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
    print('body$body');
    print('repost${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> islike(
      String postid, String uid, String token) async {
    print('sendcomment');
    var url = "${Api.url}api/post/$postid/like";
    final headers = {
      "userid": uid,
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

  static Future<Http.Response> islikecomment(
      String postid, String uid, String token, String commentid) async {
    print('islikecomment');
    var url =
        "${Api.url}api/post/$postid/comment/$commentid/like";
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
    print('body$body');
    print('headers$headers');

    print('islikecomment${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> iseditcomment(String postid, String uid,
      String token, String commentid, String commenttext) async {
    print('iseditcomment');
    var url =
        "https://today-api.moveforwardparty.org/api/post/$postid/comment/$commentid";
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
    print('body$body');
    print('iseditcomment${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> isfollow(
      String postid, String uid, String token, String pageid) async {
    print('isfollow');
    var url = "https://today-api.moveforwardparty.org/api/page/$pageid/follow";
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
    print('body$body');
    print('isfollow${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> getprofilepost(String uid, String token) async {
    print('getprofilepost$uid');
    var url =
        "https://today-api.moveforwardparty.org/api/profile/$uid/post/search";
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

  // static Future<Http.Response> getpostsearch(
  //     String uid, String token, String postid) async {
  //   // print('getpostsearch$postid');
  //   var url = "https://today-api.moveforwardparty.org/api/post/search";
  //   final headers = {
  //     "authorization": "Bearer $token",
  //     "userid": uid,
  //     "content-type": "application/json",
  //     "accept": "application/json"
  //     // "whereConditions": {"isHideStory": false},
  //   };
  //   Map data = {
  //     "limit": 5,
  //     "count": false,
  //     "whereConditions": {"_id": postid}
  //   };
  //   var body = jsonEncode(data);
  //   final responseData = await Http.post(
  //     url,
  //     headers: headers,
  //     body: body,
  //   );
  //   print('body$body');
  //   print('getpostsearch1${responseData.body}');
  //   return responseData;
  // }

  static Future<Http.Response> getpagess(
      String uid, String token, String pageid) async {
    print('getpagess');
    final headers = {
      "authorization": "Bearer $token",
      "userid": uid,
      "content-type": "application/json",
      // "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    print('getPostDetailSS');

    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/page/$pageid",
        headers: headers);

    return responseData;
  }

  static Future<Http.Response> setimagecover(
      String uid, String base64image, String fileName, String token) async {
    print('updataimage');
    var url = "https://today-api.moveforwardparty.org/api/profile/$uid/cover";
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
    print('body$body');
    print('responseupdataimage${responseData.body}');

    return responseData;
  }

  static Future<Http.Response> createpost(
      String uid, String token, String title, String detail) async {
    print('createpost');
    var url = "https://today-api.moveforwardparty.org/api/page/null/post";
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
    print('body$body');
    print('repost${responseData.body}');

    return responseData;
  }
}
