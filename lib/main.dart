import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mfp_app/utils/app_theme.dart';
import 'package:mfp_app/view/splash_page.dart';

void main()async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: AppTheme.textTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
      ),
      designSize: const Size(360, 640),
    );
  }
}
