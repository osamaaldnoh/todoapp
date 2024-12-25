import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:todoapp/model/task.dart';
import 'package:todoapp/view/notifications/notifications_view.dart';

class NotificationsHelper extends GetxController 
{

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  RxString selectNotificationsPayLoad = "".obs;

  // final BehaviorSubject<String?> selectNotificationsSubject =
  // BehaviorSubject<String?>();

  @override
  void onInit() {
    initializeNotifications();
    super.onInit();
  }

  initializeNotifications({bool? isInitializeOne=false})
  async
  {
    // _configureSelectNotificationsSubject();
     isInitializeOne == false? _configureLoaclTimeZone():null;
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);

      final AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("mipmap/ic_launcher");
      final InitializationSettings initializationSettings =
      InitializationSettings(
        android: androidInitializationSettings,
        iOS: initializationSettingsIOS,
      );
       final NotificationAppLaunchDetails? notificationAppLaunchDetailsTap =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    final didNotificationLaunchApp =
        notificationAppLaunchDetailsTap?.didNotificationLaunchApp ?? false;
      if (notificationAppLaunchDetailsTap != null &&
    notificationAppLaunchDetailsTap.didNotificationLaunchApp) {
      selectNotificationsPayLoad.value = notificationAppLaunchDetailsTap.payload!;
        // onTapLocalNotification(data);
         print("OOOOOOOOOOOOOOOOOOOOOOOOO");
         _configureSelectNotificationsSubject();
      // onTapLocalNotification(notificationAppLaunchDetailsTap.payload);
  // onTapLocalNotification(notificationAppLaunchDetails.notificationResponse);
}

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
       onSelectNotification: 
       (data)
      {
        if(data != null)
        {
          print("dataaaaaaaaaaa");
          // onTapLocalNotification(data);
        }
        selectNotificationsPayLoad.value = data!;
        // onTapLocalNotification(data);
         print("OOOOOOOOOOOOOOOOOOOOOOOOO");
         _configureSelectNotificationsSubject();
        
      }
      );    
  }

   void onTapLocalNotification(String? payload) async {
    final String? payLoading= payload;
    debugPrint(payload);
    // this is where my navigation happens
     Navigator.push(Get.context!, MaterialPageRoute(builder: 
              (context)=>NotificationsView(payLoad: selectNotificationsPayLoad.value,)));;
  }

  void requestIOSPermission()
  {
    flutterLocalNotificationsPlugin.
    resolvePlatformSpecificImplementation
    <IOSFlutterLocalNotificationsPlugin>()?.
    requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  Future<void> _configureLoaclTimeZone()
  async
  {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    // try {
      tz.setLocalLocation(tz.getLocation(timeZoneName));
//     } catch (e) {
// // Failed to get timezone or device is GMT or UTC, assign generic timezone
//       String co = "'";
//       String fallback = "Yemen/Sana${co}a";
//       tz.setLocalLocation(tz.getLocation(fallback));
//     }
     
    // const String timezoneName = 'Asia/Shanghai';
    // tz.setLocalLocation(tz.getLocation(timezoneName));
  }

  Future onDidReceiveLocalNotification(
    int id,String? title, String? body, String? payLoad
  )
  async
  {
    Get.dialog(
      Text('Welcome Osama'),
    );
    //  showDialog(
    //   context: Get.context!,
    //  builder: (context) {
    //    return CupertinoAlertDialog(
    //     title: Text(title ?? ""),
    //     content: Text(body ?? ""),
    //     actions: 
    //     [
    //       CupertinoDialogAction(
    //         child: Text("Close"),
    //         isDestructiveAction: true,
    //         onPressed: ()
    //         {
    //           Get.back();
    //         },
    //         ),

    //         CupertinoDialogAction(
    //         child: Text("View"),
    //         onPressed: ()
    //         {
    //           // Get.back();
    //         },
    //         )
    //     ],
    //    );
    //  },
    //  );
  }

  scheduledNotifications(int days,int hours, int minutes, int seconds, Task task)
  async
  {tz.initializeTimeZones();
    // final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id??0,
      task.title,
      task.desc, 
       _converTimeLocal(days, hours, minutes, seconds),
     const NotificationDetails(
        android: AndroidNotificationDetails(
          "channelId", 
          "channelName",
          ),
      ),
      androidAllowWhileIdle: true,
       uiLocalNotificationDateInterpretation: 
       UILocalNotificationDateInterpretation.absoluteTime,
       matchDateTimeComponents: DateTimeComponents.time,
       payload: "${task.title}|${task.desc}|${task.date}|${task.startTime}|${task.endTime}",
       );
  }


  _configureSelectNotificationsSubject()
  {
    print("selectNotificationsPayLoad ::::::::${selectNotificationsPayLoad.value}");
    selectNotificationsPayLoad.stream.listen((event) {
      var title = event.split('|')[0];
    var body = event.split('|')[1];
   
    showDialog(
      context: Get.context!,
     builder: (context) {
       return CupertinoAlertDialog(
        title: Text(title),
        content: Text(body,textAlign: TextAlign.justify,maxLines: 4,),
        actions: 
        [
          CupertinoDialogAction(
            child: Text("Close"),
            isDestructiveAction: true,
            onPressed: ()
            {
              Get.back();
            },
            ),

            CupertinoDialogAction(
            child: Text("View"),
            onPressed: ()
            {
              Get.back();
              Navigator.push(context, MaterialPageRoute(builder: 
              (context)=>NotificationsView(payLoad: selectNotificationsPayLoad.value,)));

              // Get.to(NotificationsView(payLoad: selectNotificationsPayLoad.value,));
            },
            )
        ],
       );
     },
     );
 
    });

    
  }

 
  tz.TZDateTime _converTimeLocal(int days,int hours, int minutes, int seconds)
  {
   
    //  tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    return tz.TZDateTime.now(tz.local)
      .add(Duration(days: days,hours: hours,minutes: minutes,seconds: seconds)); 
      
  }
}