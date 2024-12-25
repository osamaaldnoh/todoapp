import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';
import 'package:todoapp/res/widgets/hieght_spacer.dart';
import 'package:todoapp/res/widgets/reusable_text.dart';
import 'package:todoapp/res/widgets/width_spacer.dart';

import '../../controllers/task_controller.dart';
import '../appcolor.dart';

class BottomTitles extends StatelessWidget {
   BottomTitles(
      {Key? key, required this.widgetText, required this.widgetText2, this.clr})
      : super(key: key);

  final String widgetText;
  final String widgetText2;
  final Color? clr;

  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
     
    SizeConfig.init(context);
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() {
            dynamic color = taskController.getRandomColor();
              return Container(
              height: 80.h,
              width: 5.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppColors.kRadius),
                  color: color),
            );
            }),
            const WidthSpacer(width: 15),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: widgetText,
                    style: appStyle(
                      24,
                      AppColors.kLight,
                      FontWeight.bold,
                    ),
                  ),
                  HieghtSpacer(height: 10),
                  ReusableText(
                    text: widgetText2,
                    style: appStyle(
                      12,
                      AppColors.kLight,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
