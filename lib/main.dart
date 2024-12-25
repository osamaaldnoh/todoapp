import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoapp/data/local/services/db_helpers.dart';
import 'package:todoapp/model/user_model.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/binding/binding.dart';
import 'package:todoapp/utils/notification/notification_helper.dart';
import 'package:todoapp/utils/routes/route_name.dart';
import 'package:todoapp/utils/routes/route_view.dart';
import 'controllers/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //  await NotificationsHelper().initializeNotifications();
  //  await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  DBHelper();
  BuildBindin().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark, primarySwatch: Colors.blue);
  UserController userController = Get.find();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // userController.deletUser(UserModel(id: 1, isVerified: 1));
    // userController.refresh();
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(AppColors.kWidth, AppColors.kHieght),
      // designSize: Size(AppColors.kWidth, AppColors.kHieght),
      minTextAdapt: true,
      builder: (context, child) {
        return DynamicColorBuilder(
            builder: (lightColorScheme, darkColorScheme) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.kBkDark,
              // primarySwatch: Colors.blue,
              colorScheme: lightColorScheme ?? defaultLightColorScheme,
              // colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorScheme ?? defaultDarkColorScheme,
              scaffoldBackgroundColor: AppColors.kBkDark,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.dark,
            // initialBinding: BuildBindin(),
            getPages: RouteView.listView(),
            initialRoute: userController.userList.isNotEmpty
                ? RouteName.homeView
                : RouteName.onBoardingView,
          );
        });
      },
    );
  }
}
// import 'package:dynamic_color/dynamic_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:todoapp/res/appcolor.dart';
// import 'package:todoapp/res/binding/binding.dart';
// import 'package:todoapp/utils/routes/route_name.dart';
// import 'package:todoapp/utils/routes/route_view.dart';

// void main() {
//   runApp(const MyApp());
// }


