import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:todoapp/utils/routes/route_name.dart';
import 'package:todoapp/view/home/widgets/todo_tile.dart';

import '../../../controllers/task_controller.dart';

class TodayTask extends StatelessWidget {
   TodayTask({
    super.key,
  });

  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String today = taskController.getToday();
      var todayList = taskController.taskList.where(
        (element) => element.isCompleted==0 && element.date!.contains(today)).toList();

        dynamic color = taskController.getRandomColor();
      return ListView.builder(
      itemCount: todayList.length,
      itemBuilder: (ctx,index)
      {
        return  TodoTile(
          title: todayList[index].title,
          color: color,
          description: todayList[index].desc,
          start: todayList[index].startTime,
          end: todayList[index].endTime,
          switcher: Switch(
            value: taskController.getStatus(todayList[index]),
            onChanged: (value) {
              taskController.markAsCompleted(todayList[index]);
            },
          ),
          editWidget: GestureDetector(
            onTap: () =>Get.toNamed(RouteName.editTaskView,
            arguments: {
              'id': todayList[index].id ?? 0
            }
            ),
            child: const Icon(MaterialCommunityIcons.circle_edit_outline),
          ),
          delete: ()=> taskController.deletTask(todayList[index]),
        );
      },
      );
                  
    });
  }
}
