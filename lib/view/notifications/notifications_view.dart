import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';
import 'package:todoapp/res/widgets/hieght_spacer.dart';
import 'package:todoapp/res/widgets/reusable_text.dart';
import 'package:todoapp/res/widgets/width_spacer.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key,this.payLoad});

  final String? payLoad;
  @override
  Widget build(BuildContext context) {
    var title = payLoad!.split('|')[0];
    var desc = payLoad!.split('|')[1];
    var data = payLoad!.split('|')[2];
    var start = payLoad!.split('|')[3];
    var end = payLoad!.split('|')[4];
    
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight*0.7,
                decoration: BoxDecoration(
                  color: AppColors.kBkLight,
                  borderRadius: BorderRadius.all(Radius.circular(AppColors.kRadius),),         
                ),
                child: Padding(
                  padding:  EdgeInsets.all(12.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(text: "Reminder",
                      style: appStyle(40, AppColors.kLight, FontWeight.bold),
                      ),

                      HieghtSpacer(height: 5),
                      Container(
                        width: SizeConfig.screenWidth,
                        padding: EdgeInsets.only(left: 8.w),
                        decoration: BoxDecoration(
                          color: AppColors.kYellow,
                          borderRadius: BorderRadius.all(Radius.circular(9.h)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             ReusableText(text: "Today",
                                    style: appStyle(14, AppColors.kBkDark, FontWeight.bold),
                                    ),
                                    WidthSpacer(width: 15),
                                     ReusableText(text: "From : ${start} To : ${end}",
                                            style: appStyle(15, AppColors.kBkDark, FontWeight.w600),
                                            ),
                          ],
                        ),
                      ),
                      ReusableText(text: title,
                                 style: appStyle(30, AppColors.kBkDark, FontWeight.bold),
                                  ),
                      HieghtSpacer(height: 10),
                      Text(desc,
                      maxLines: 8,
                      textAlign: TextAlign.justify,
                      style: appStyle(16, AppColors.kLight, FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 12.w,
              top: -10,
              child: Image.asset("assets/images/todo.png",
            width: 70.w,height: 70.h,),
            
            ),

            Positioned(
              bottom: -SizeConfig.screenHeight*0.143,
              left: 0,
              right: 0,
              child: Image.asset("assets/images/todo.png",
            width: SizeConfig.screenWidth*0.8,height: SizeConfig.screenHeight*0.6,),
            
            ),
          ],
        ),
      ),
    );
  }
}