import 'package:get/get.dart';
import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/model/postModel.dart';

class EmergencyController extends GetxController {
  EmergencyController emergencyController;

  EmergencyController({this.emergencyController});

  RxList<EmergencyEventsContent> emergencyevList =
      <EmergencyEventsContent>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    // getmergencyevents();
    super.onInit();
  }

  getmergencyevents() async {
    print('getmergencyevents');
    try {
      if (emergencyevList.length == 0) {
        isLoading(true);
        emergencyevList.clear();
      }
      var emergencys = await Api.getPostemergencyEventsList();
      if (emergencys != null) {
        emergencyevList.addAll(emergencys);
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
