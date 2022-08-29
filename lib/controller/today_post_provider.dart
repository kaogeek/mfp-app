import 'dart:convert';

import 'package:get/get.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/model/RecommendedUserPageModel.dart';
import 'package:mfp_app/model/searchpostlist.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';

class TodayPostController extends GetxController {
  RxList<PostSearchModel> postList = <PostSearchModel>[].obs;
  RxList<RecomUserPageModel> recompageList = <RecomUserPageModel>[].obs;
  RxList<PostSearchModel> serarchpostList = <PostSearchModel>[].obs;

  var _currentMax = 0.obs;
  var isLoading = true.obs;
  var firstload = true.obs;
  var isLoadingmore = true.obs;

  var idloadingstory = true.obs;
  var storycontent = "";
  var id = "";
  var postid;
  RxString titalpost = "".obs;
  var imagUrl;
  //  String type;
  var createdDate;
  var postby;
  var imagepage;
  var likeCount;
  var commentCount;
  var shareCount;
  var repostCount;
  RxString stroycoverImage = "".obs;

  var islike = false.obs;

  var storytestreplaceAll = "";
  @override
  void onInit() async {
    // await getpost(_currentMax);
    // await getrecompage();
    // await getstory(id);
    super.onInit();
  }

  getpost(var offset,var userid ,{var pagenumber = 0}) async {
    //('getmergencyevents');
    try {
      if (postList.length == 0) {
        isLoading(true);
        firstload(true);
        postList.clear();
      }
      var posts = await Api.getpostlisttest(offset,userid);
      if (posts != null) {
        postList.addAll(posts);
        update();
      }
    } finally {
      isLoading(false);
    }
  }

  getislike(String postid, String userid, String token, String mode) async {
    var jsonResponse;
    var Islike;
     Api.islike(postid, userid, token, "").then((value) => ({
          jsonResponse = jsonDecode(value.body),
          //('message${jsonResponse['message']}')
          if (value.statusCode == 200)
            {
              if (jsonResponse['message'] == "Like Post Success")
                {
                  Islike = jsonResponse['data']['isLike'],
                  islike(true),
                }
              else if (jsonResponse['message'] == "UnLike Post Success")
                {
                  islike = jsonResponse['data']['isLike'],
                  islike(false),
                }
            }
        }));
  }

  getsearchpostList(var label, var userid, var keyword, var offset,
      {var pagenumber = 0}) async {
    //print('getsearchpostList');
    try {
      print('pagenumber$pagenumber');
      if (serarchpostList.length == 0 || pagenumber == 0) {
        isLoading(true);
        serarchpostList.clear();
      }

      var searchposts = await Api.apisearchlist(label,userid, keyword, offset);
      if (searchposts != null) {
        serarchpostList.addAll(searchposts);
        print('length${serarchpostList.length}');
        update();
      }
    } finally {
      isLoading(false);
    }
  }

  getrecompage() async {
    //('getrecompage');
    try {
      if (recompageList.length == 0) {
        recompageList.clear();
      }
      var pages = await Api.getRecommendedUserPage();
      if (pages != null) {
        recompageList.addAll(pages);
      }
    } finally {
      isLoading(false);
    }
  }

  getstory(String id,String userid) async {
    //('getstory');
    try {
      idloadingstory.value = true;
      var responseRequest = await Api.getstory(id,userid);
      if (responseRequest.statusCode == 200) {
        final jsonResponse = jsonDecode(responseRequest.body);
        for (Map i in jsonResponse["data"]) {
          var storytest = i["story"]["story"];
          var tital = i["title"];
          // var stroycoverImage= i["coverImage"];
          storytestreplaceAll = storytest.replaceAll("<create-text>", "");
          titalpost.value = tital;
        }
        //("Response  :$storytestreplaceAll");
        //('titalpost$titalpost');
      }
      if (responseRequest.statusCode == 400) {
        return null;
      }
      idloadingstory.value = false;
    } finally {
      idloadingstory.value = false;
    }
  }
}
