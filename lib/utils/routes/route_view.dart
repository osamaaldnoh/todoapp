import 'package:get/get.dart';
import 'package:todoapp/utils/routes/route_name.dart';
import 'package:todoapp/view/add/add_view.dart';
import 'package:todoapp/view/edit/edit_task_view.dart';
import 'package:todoapp/view/home/home_view.dart';
import 'package:todoapp/view/login/login_view.dart';
import 'package:todoapp/view/notifications/notifications_view.dart';
import 'package:todoapp/view/onboarding/onboarding_view.dart';
import 'package:todoapp/view/otp/otp_view.dart';

class RouteView 
{
  static List<GetPage> listView()
  {
    return 
    [
      GetPage(name: RouteName.homeView, page: ()=> HomeView()),
      GetPage(name: RouteName.onBoardingView, page: ()=> OnBoardingView()),
      GetPage(name: RouteName.loginView, page: ()=> LoginView()),
      GetPage(name: RouteName.otpView, page: ()=> OtpView()),
      GetPage(name: RouteName.addView, page: ()=> AddView()),
      GetPage(name: RouteName.editTaskView, page: ()=> EditTaskView()),
      GetPage(name: RouteName.notificationsView, page: ()=> NotificationsView()),

    ];
  }
}