import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:todoapp/controllers/add_controller.dart';
import 'package:todoapp/controllers/notification_controller.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';
import 'package:todoapp/res/widgets/custom_otn_btn.dart';
import 'package:todoapp/res/widgets/custom_text_feild.dart';
import 'package:todoapp/res/widgets/hieght_spacer.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:todoapp/utils/notification/notification_helper.dart';

import '../../controllers/task_controller.dart';


class AddView extends StatelessWidget {
   AddView({super.key});
  final AddController addController = Get.find();
  final TaskController taskController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();
   NotificationController notificationController = Get.find();
  Task task = Task();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const HieghtSpacer(height: 20),
              CustomTextFeild(hintText: 'Add title',
               controller: addController.title,
               hintStyle: appStyle(16, AppColors.kGreyLight, FontWeight.w600),
               onChanged: (value)
               {
                task.title = value;
               },
               ),
        
              const HieghtSpacer(height: 20),
              CustomTextFeild(hintText: 'Add description',
               controller: addController.desc,
               onChanged: (value)
               {
                task.desc = value;
               },
               hintStyle: appStyle(16, AppColors.kGreyLight, FontWeight.w600),
               ),
              const HieghtSpacer(height: 20),
              Obx(() => CustomOtnlBtn(width: SizeConfig.screenWidth,
               height: 52.h, 
               color: AppColors.kLight,
              color2: AppColors.kBlueLight,
                text: addController.selectDate.value == ""? "Set Date"
                :addController.selectDate.value,
                onTap: () {
                  
                      addController.showDatePicker(context: context);
                },
               ),),
               const HieghtSpacer(height: 20),
              Obx(() =>  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomOtnlBtn(
                    width: SizeConfig.screenWidth*0.4,
                    height: 52.h, 
                    color: AppColors.kLight,
                    color2: AppColors.kBlueLight,
                      text: addController.startTime.value == ""? "Start Time"
                      :addController.startTime.value,
                      onTap: (){
                        addController.showDateTimePicker(context: context,start: true);
                        },
                    ),
        
               CustomOtnlBtn(
                width: SizeConfig.screenWidth*0.4,
                  height: 52.h, 
                  color: AppColors.kLight,
                  color2: AppColors.kBlueLight,
                     text: addController.finishTime.value == ""? "Finish Time"
                      :addController.finishTime.value,
                      onTap: () {
                        addController.showDateTimePicker(context: context,start: false);
        
                      },
                  ),
                ],
               ),
        ),
                const HieghtSpacer(height: 20),
              CustomOtnlBtn(width: SizeConfig.screenWidth,
               height: 52.h, 
               color: AppColors.kLight,
              color2: AppColors.kGreen,
                text: "Submit",
               onTap: ()
               async{
                if(!formKey.currentState!.validate())
                {
                  return;
                }
                formKey.currentState!.save();
                if(addController.selectDate.isNotEmpty
                &&addController.startTime.isNotEmpty
                &&addController.finishTime.isNotEmpty)
                {
                  task.date = addController.selectDate.value;
                  task.startTime = addController.startTime.value;
                  task.endTime = addController.finishTime.value;
                  task.isCompleted = 0;
                  task.remind = 0;
                  task.repeat = 'yes';
                  taskController.addTask(task);
                  notificationController.scheduledNotificationes(
                    addController.notification[0],
                    addController.notification[1],
                    addController.notification[2],
                    addController.notification[3],
                     task);

                   
                   

                }
               },
               ),
            ],
          ),
        ),
      ),
    );
  }
}