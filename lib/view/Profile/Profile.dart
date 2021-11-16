import 'package:flutter/material.dart';
import 'package:mfp_app/allWidget/allWidget.dart';


class ProfileSc extends StatefulWidget {
  ProfileSc({Key key}) : super(key: key);

  @override
  _ProfileScState createState() => _ProfileScState();
}

class _ProfileScState extends State<ProfileSc> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            controller: _trackingScrollController,
            slivers: [
              primaryAppBar(context,""),

              ///-----------APPBAR-----------------//

              ///-----------SliverListปิดไปก่อนได้----------------//
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          scrollDirection: Axis.vertical,
                          itemCount: 50,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return ListTile(
                              title: Text('test$index'),
                            );
                          });
                    },
                  );
                }, childCount: 1),
              ),
            ],
          ),
        ),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(),

    //   body:

    // );
  }
}
