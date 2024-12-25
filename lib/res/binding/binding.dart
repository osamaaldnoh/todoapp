import 'package:get/get.dart';
import 'package:todoapp/controllers/add_controller.dart';
import 'package:todoapp/controllers/auth_controller.dart';
import 'package:todoapp/controllers/home_controller.dart';
import 'package:todoapp/controllers/login_controller.dart';
import 'package:todoapp/controllers/notification_controller.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/controllers/user_controller.dart';
import 'package:todoapp/utils/notification/notification_helper.dart';

import '../../controllers/onboarding_controller.dart';
import '../../controllers/otp_controller.dart';

class BuildBindin extends Bindings
{
  @override
  void dependencies() 
  {
    Get.lazyPut(() => HomeController(),fenix: true);
    Get.lazyPut(() => OnBoardingController(),fenix: true);
    Get.lazyPut(() => LoginController(),fenix: true);
    Get.lazyPut(() => AddController(),fenix: true);
    Get.lazyPut(() => TaskController(),fenix: true);
    Get.lazyPut(() => AuthController(),fenix: true);
    Get.lazyPut(() => UserController(),fenix: false);
    Get.lazyPut(() => OtpController(),fenix: true);
    Get.lazyPut(() => NotificationsHelper(),fenix: true);

    Get.lazyPut(() => NotificationController(),fenix: true);

  }
  
}