import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/add_controller.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';
import 'package:todoapp/res/widgets/custom_otn_btn.dart';
import 'package:todoapp/res/widgets/custom_text_feild.dart';
import 'package:todoapp/res/widgets/hieght_spacer.dart';
import '../../controllers/task_controller.dart';


class EditTaskView extends StatelessWidget {
   EditTaskView({super.key});
  final AddController addController = Get.find();
  final TaskController taskController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey();
  Task taskModel = Task();

  final int id = Get.arguments['id'];

  @override
  Widget build(BuildContext context) {
    print("idididididididididididididid$id");
     taskModel = taskController.findByID(id: id);
    print("idididididididididididididid$id");

   addController.isEditTasks(isEdit: true,task: taskModel);
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
                taskModel.title = value;
               },
               ),
        
              const HieghtSpacer(height: 20),
              CustomTextFeild(hintText: 'Add description',
               controller: addController.desc,
               onChanged: (value)
               {
                taskModel.desc = value;
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
               {
                if(!formKey.currentState!.validate())
                {
                  return;
                }
                formKey.currentState!.save();
                if(addController.selectDate.isNotEmpty
                &&addController.startTime.isNotEmpty
                &&addController.finishTime.isNotEmpty)
                {
                  // taskModel.id = taskController.findByID(id: id).id;
                  taskModel.date = addController.selectDate.value;
                  taskModel.startTime = addController.startTime.value;
                  taskModel.endTime = addController.finishTime.value;
                  taskModel.isCompleted = 0;
                  taskModel.remind = 0;
                  taskModel.repeat = 'yes';
                  // print('id ${taskModel.id}');
                  // print('id ${taskModel.title}');
                  // print('des ${taskModel.desc}');
                  // print('id ${taskModel.date}');

                  taskController.updataTask(taskModel);
                  

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