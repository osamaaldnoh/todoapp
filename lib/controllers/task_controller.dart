import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/data/local/tables/task_db.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/res/appcolor.dart';

class TaskController extends GetxController
{
  RxList<Task> _taskList = RxList<Task>();
  RxList<Task> get taskList  => RxList([..._taskList]);

  @override
  void onInit() {
    refresh();
    super.onInit();
  }

  void refresh() 
  async
  {
    _taskList.value = await TaskDB().getAllTasks();
  }

  void addTask(Task task)
  async
  {
    await TaskDB().createTask(task);
    refresh();
  
     Get.back();
  }
  Task findByID({required int id})
  {
    return _taskList.firstWhere((element) => element.id == id);
  }

  dynamic getRandomColor()
  {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }

  void updataTask(Task task)
  async
  {
    await TaskDB().updata(task);
    refresh();
    Get.back();
  }

void deletTask(Task task)
  async
  {
    await TaskDB().delete(task);
    refresh();
  }

  void markAsCompleted(Task task)
  async
  {
    task.isCompleted = 1;
    await TaskDB().updata(task);
    refresh();
  }

  // Today
  String getToday()
  {
    DateTime today = DateTime.now();
    return today.toString().substring(0,10);
  }

  // Tomorrow
  String getTomorrow()
  {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return tomorrow.toString().substring(0,10);
  }

    String getAfterTomorrow()
  {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 2));
    return tomorrow.toString().substring(0,10);
  }

   // Tomorrow
  List<String> last30Days()
  {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));
    List<String> dates = [];
    for(int i = 0; i < 30;i++)
    {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0,10));
    }

    return dates;
  }

  bool getStatus(Task task)
  {
    bool? isCompleted;

    if(task.isCompleted == 0)
    {
      isCompleted = false;
    }
    else
    {
      isCompleted = true;
    }
    return isCompleted;

  }
}