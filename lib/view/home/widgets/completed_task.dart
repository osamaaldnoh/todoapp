import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/view/home/widgets/todo_tile.dart';

import '../../../controllers/task_controller.dart';

class CompletedTask extends StatelessWidget {
   CompletedTask({
    super.key,
  });

  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List lastMonth = taskController.last30Days();
      var completedList = taskController.taskList.where(
        (element) => element.isCompleted == 1 || lastMonth.contains(element.date!.substring(0,10))).toList();

        dynamic color = taskController.getRandomColor();
      return ListView.builder(
      itemCount: completedList.length,
      itemBuilder: (ctx,index)
      {
        return  TodoTile(
          title: completedList[index].title,
          color: color,
          description: completedList[index].desc,
          start: completedList[index].startTime,
          end: completedList[index].endTime,
          switcher: const Icon(AntDesign.checkcircle,color: AppColors.kGreen,),
          editWidget: const SizedBox.shrink(),
          delete: ()=> taskController.deletTask(completedList[index]),
        );
      },
      );
                  
    });
  }
}
