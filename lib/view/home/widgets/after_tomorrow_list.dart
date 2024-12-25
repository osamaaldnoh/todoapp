import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/home_controller.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/view/home/widgets/todo_tile.dart';
import '../../../res/appcolor.dart';
import '../../../res/widgets/xpansion_tile.dart';
import '../../../utils/routes/route_name.dart';

class AfterTomorrowList extends StatelessWidget {
   AfterTomorrowList({super.key});
  final HomeController homeController = Get.find();
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var todos = taskController.taskList;
    String afterTomorrow = taskController.getAfterTomorrow();
    var afterTomorrowTask = taskController.taskList.where((element) => element.date!.contains(afterTomorrow)).toList().obs;
    dynamic color = taskController.getRandomColor();
      return XpansionTile(
              text: DateTime.now()
                  .add(const Duration(days: 2))
                  .toString()
                  .substring(5, 10),
              text2: "Tomorrow's task are shown here",
              onExpansionChanged: (bool value)
              {
                homeController.isExpansionChange1.value = value; 
              },
              trailing: Obx(() => Padding(
                padding: EdgeInsets.only(right: 12.0.w),
                child: homeController.isExpansionChange1.value?
                 const Icon(AntDesign.closecircleo,color: AppColors.kBlueLight,)
                 :const Icon(AntDesign.circledown,color: AppColors.kLight,),
              ),),
              children:afterTomorrowTask.map((element) { 
                return TodoTile(
                  title: element.title,
                  description: element.desc,
                  color: color,
                  start: element.startTime,
                  end: element.endTime,
                  switcher: const SizedBox.shrink(),
                  editWidget: GestureDetector(
                  onTap: ()=>Get.toNamed(RouteName.editTaskView,
                  arguments: {
                    'id': element.id ?? 0
                  },
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