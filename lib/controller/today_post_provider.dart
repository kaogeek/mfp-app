import 'package:get/get.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/model/RecommendedUserPageModel.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';

class TodayPostController extends GetxController {
 
  RxList<PostSearchModel> postList = <PostSearchModel>[].obs;
    RxList<RecomUserPageModel> recompageList = <RecomUserPageModel>[].obs;
  var _currentMax = 0.obs;
  var isLoading = true.obs;
  var firstload = true.obs;
  var idloadingstory = false.obs;
  var storycontent ="";
  var id="";
  @override
  void onInit()async {
  await getpost(_currentMax);
  await  getrecompage();
  await getstory(id);
    super.onInit();
  }

getpost(var offset) async {
    print('getmergencyevents');
    try {
      if (postList.length == 0) {
        isLoading(true);
        firstload(true);
        postList.clear();
      }
      var posts = await Api.getpostlisttest(offset);
      if (posts != null) {
        postList.addAll(posts);
      }
    } finally {
      isLoading(false);
    }
  }
 
 
 
getrecompage() async {
    print('getrecompage');
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

  getstory(String id) async{
    print('getstory');
    try {
      idloadingstory.value=true;
      storycontent = await Api.getstory(id);
       idloadingstory.value=false;
    } finally {
      idloadingstory.value=false;
    }
  }
}
