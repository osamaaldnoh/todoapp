import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/home_controller.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/view/home/widgets/todo_tile.dart';

import '../../../res/appcolor.dart';
import '../../../res/widgets/xpansion_tile.dart';
import '../../../utils/routes/route_name.dart';

class TomorrowList extends StatelessWidget {
   TomorrowList({super.key});
  final HomeController homeController = Get.find();
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var todos = taskController.taskList;
    String tomorrow = taskController.getTomorrow();
    var tomorrowTask = taskController.taskList.where((element) => element.date!.contains(tomorrow)).toList().obs;
    dynamic color = taskController.getRandomColor();
      return XpansionTile(
              text: "Tomorrow's task",
              text2: "Tomorrow's task are shown here",
              onExpansionChanged: (bool value)
              {
                homeController.isExpansionChange.value = value; 
              },
              trailing: Obx(() => Padding(
                padding: EdgeInsets.only(right: 10.0.w),
                child: homeController.isExpansionChange.value?
                 const Icon(AntDesign.closecircleo,color: AppColors.kBlueLight,)
                 :const Icon(AntDesign.circledown,color: AppColors.kLight,),
              ),),
              children:tomorrowTask.map((element) { 
                return TodoTile(
                  title: element.title,
                  description: element.desc,
                  color: color,
                  start: element.startTime,
                  end: element.endTime,
                  switcher: const SizedBox.shrink(),
                  editWidget: GestureDetector(
                  onTap: () =>Get.toNamed(RouteName.editTaskView,
                  arguments: {
                    'id': element.id ?? 0
                  }
            ),
                  child: Icon(MaterialCommunityIcons.circle_edit_outline),
             ),
                  delete: ()=> taskController.deletTask(element),

                          );
                          }).toList(),
            );
  
    });        
  }
}