
import 'dart:async';
import 'dart:convert';

import 'package:mfp_app/Api/Api.dart';
import 'package:mfp_app/model/searchpostlistModel.dart';

class ApiPost{
 static  var dataht, datapostlist, myuid, dataht1;
 static  List<PostSearchModel> listModelPostClass = [];
 static  StreamController _postsController;
static  bool isLoading= true;
 
  Future getpost (int _currentMax) async{
   Api.getPostList(_currentMax).then((value) {
     return {
            if (value.statusCode == 200)
              {
              
                datapostlist = jsonDecode(value.body),
                for (Map i in datapostlist["data"])
                  {
                    listModelPostClass.add(PostSearchModel.fromJson(i)),
                    _postsController.add(value),
                  },
               
              }
          };
   });
   return listModelPostClass;
 }
  
}