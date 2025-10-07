import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:taswaq_app/config/routes/app_route.dart';
import 'core/cashe/shared_preferences.dart';
import 'core/network/dio_helper_for_paymob.dart';
import 'core/utils/observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.init();
  Bloc.observer = MyBlocObserver();
  String? token = await CacheData.getData("token");
  String start;
  if (token == null) {
    start = "/";
    // start = "homeScreen";

  } else {
    start = "home";
  }


  // runApp(
      // DevicePreview(
      // enabled: !kReleaseMode,
      // builder: (context) => MyApp(start),
      // ));
  runApp(MyApp(start));
}

class MyApp extends StatelessWidget {
  final String start ;
  MyApp(this.start,{super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        initialRoute: start,
      ),
    );
  }
}
