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
        themeMode: ThemeMode.light, // Change it as you want
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: AppTheme.textTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
           primaryColor: Colors.white,
        primaryColorBrightness: Brightness.light,
        brightness: Brightness.light,
        primaryColorDark: Colors.black,
        canvasColor: Colors.white,
        ),
         darkTheme: ThemeData(
        primaryColor: Colors.black,
        primaryColorBrightness: Brightness.dark,
        primaryColorLight: Colors.black,
        brightness: Brightness.dark,
        primaryColorDark: Colors.black,      
        indicatorColor: Colors.white,
        canvasColor: Colors.black,
        // next line is important!
        appBarTheme: AppBarTheme(brightness: Brightness.dark)),
        home: SplashPage(),
      ),
      designSize: const Size(360, 640),
    );
  }
}
