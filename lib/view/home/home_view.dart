import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/home_controller.dart';
import 'package:todoapp/controllers/notification_controller.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';
import 'package:todoapp/res/widgets/custom_text_feild.dart';
import 'package:todoapp/res/widgets/width_spacer.dart';
import 'package:todoapp/res/widgets/xpansion_tile.dart';
import 'package:todoapp/utils/routes/route_name.dart';
import 'package:todoapp/view/home/widgets/after_tomorrow_list.dart';
import 'package:todoapp/view/home/widgets/completed_task.dart';
import 'package:todoapp/view/home/widgets/today_task.dart';
import 'package:todoapp/view/home/widgets/todo_tile.dart';
import 'package:todoapp/view/home/widgets/tomorrow_list.dart';

import '../../res/widgets/hieght_spacer.dart';
import '../../res/widgets/reusable_text.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  HomeController homeController = Get.find();
  NotificationController notificationController = Get.find();
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    print("padding:  ${18.sp}");
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: 'Dashboard',
                      style: appStyle(18, AppColors.kLight, FontWeight.bold),
                    ),
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: AppColors.kLight,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteName.addView);
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppColors.kBkDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const HieghtSpacer(height: 20),
              CustomTextFeild(
                hintText: 'Search',
                controller: homeController.searchController,
                prefixIcon: Container(
                  padding: EdgeInsets.all(14.h),
                  child: GestureDetector(
                    onTap: null,
                    child: const Icon(
                      AntDesign.search1,
                      color: AppColors.kGreyLight,
                    ),
                  ),
                ),
                suffixIcon: const Icon(
                  FontAwesome.sliders,
                  color: AppColors.kGreyLight,
                ),
              ),
              const HieghtSpacer(height: 15)
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          padding:  EdgeInsets.only(bottom: 20.h),
          children: [
            const HieghtSpacer(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  FontAwesome.tasks,
                  size: 20,
                  color: AppColors.kLight,
                ),
                WidthSpacer(width: 10),
                ReusableText(
                  text: "Today's Tasks",
                  style: appStyle(18, AppColors.kLight, FontWeight.bold),
                )
              ],
            ),
            const HieghtSpacer(height: 25),
            Container(
              decoration: BoxDecoration(
                color: AppColors.kLight,
                borderRadius: BorderRadius.circular(AppColors.kRadius),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  color: AppColors.kGreyLight,
                  borderRadius: BorderRadius.circular(AppColors.kRadius),
                ),
                controller: homeController.tabController,
                labelPadding: EdgeInsets.zero,
                isScrollable: false,
                labelColor: AppColors.kBlueLight,
                labelStyle: appStyle(24, AppColors.kBlueLight, FontWeight.w700),
                unselectedLabelColor: AppColors.kLight,
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: SizeConfig.screenWidth * 0.5,
                      child: Center(
                        child: ReusableText(
                          text: 'Pending',
                          style:
                              appStyle(16, AppColors.kBkDark, FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.only(left: 30.w),
                      width: SizeConfig.screenWidth * 0.5,
                      child: Center(
                        child: ReusableText(
                          text: 'Completed',
                          style:
                              appStyle(16, AppColors.kBkDark, FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const HieghtSpacer(height: 20),
            SizedBox(
              height: SizeConfig.screenHeight * 0.3,
              width: SizeConfig.screenWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppColors.kRadius),
                child: TabBarView(
                  controller: homeController.tabController,
                  children: [
                    Container(
                      color: AppColors.kBkLight,
                      height: SizeConfig.screenHeight * 0.3,
                      child: TodayTask(),
                       ),
                    Container(
                      color: AppColors.kBkLight,
                      height: SizeConfig.screenHeight * 0.3,
                      child: CompletedTask(),
                    )
                  ],
                ),
              ),
            ),
            const HieghtSpacer(height: 20),
            TomorrowList(),
            const HieghtSpacer(height: 20),
            AfterTomorrowList(),
            ],
        ),
      )),
    );
  }
}

