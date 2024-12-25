import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/utils/notification/notification_helper.dart';

import '../model/task.dart';
import '../view/notifications/notifications_view.dart';

class NotificationController extends GetxController
{
  
  NotificationsHelper notificationsHelper = NotificationsHelper();

  NotificationsHelper controllerNoti = NotificationsHelper();
  @override
  void onInit() {
    notificationsHelper = NotificationsHelper();
    Future.delayed(Duration.zero).then((value)
    {
      controllerNoti.initializeNotifications(isInitializeOne: true);
  //     Navigator.of(Get.context!).push(
  //   MaterialPageRoute(builder: (BuildContext context) {
  //     return NotificationsView();
  //   }
  // ));
    });
    
    super.onInit();
  }

 

  scheduledNotificationes(int days,int hours, int minutes, int seconds, Task task)
  async
  {
     notificationsHelper.scheduledNotifications(days, hours, minutes, seconds, task);
    // controllerNoti.initializeNotifications();
  }
}