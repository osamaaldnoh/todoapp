import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todoapp/controllers/onboarding_controller.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';
import 'package:todoapp/res/widgets/custom_otn_btn.dart';
import 'package:todoapp/res/widgets/hieght_spacer.dart';
import 'package:todoapp/res/widgets/reusable_text.dart';
import 'package:todoapp/res/widgets/width_spacer.dart';
import 'package:todoapp/utils/routes/route_name.dart';

class OnBoardingView extends StatelessWidget {
   OnBoardingView({super.key});
  final OnBoardingController onBoardingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Stack(
          
          children: 
          [
            PageView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: onBoardingController.pageController.value,
              children: 
              const[
                PageOne(color: AppColors.kBkDark),
                PageOne(color: AppColors.kBkDark,isLogin: true,),
      
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: ()=>onBoardingController.nextPage(),
                          child: Icon(
                            Ionicons.chevron_forward_circle,
                            size: 35.sp,
                            color: AppColors.kLight,
                          ),
                        ),
                        const WidthSpacer(width: 5),
                        ReusableText(text: 'Skip',
                        style: appStyle(16,
                         AppColors.kLight,
                          FontWeight.w500),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: ()=>onBoardingController.nextPage(),
                      child: SmoothPageIndicator(
                        controller: onBoardingController.pageController.value,
                       count: 2,
                       effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 16,
                        spacing: 10,
                        dotColor: AppColors.kYellow,
                       ),
                       ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({super.key,
   required this.color,
     this.isLogin=false
     });
  final Color color;
  final bool? isLogin;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: SizeConfig.screenWidth,
      height:SizeConfig.screenHeight,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset("assets/images/todo.png"),
            ),
            HieghtSpacer(height: isLogin == true? 50 :100),
           isLogin == false?Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(text: 'ToDo with Getx',
              style: appStyle(
                30,
               AppColors.kLight,
                FontWeight.w600,
                ),
              ),
           const HieghtSpacer(height: 10),
           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 30.w),
             child: Text(
              'Welcome!! Do yo want to create a task fast and with ease',
              textAlign: TextAlign.center,
             style: appStyle(
              16,
              AppColors.kGreyLight,
              FontWeight.normal),
             ),
           )
            ],
           ):CustomOtnlBtn(
            onTap: () => Get.toNamed(RouteName.loginView),
            width: SizeConfig.screenWidth*0.9,
            height: SizeConfig.screenHeight*0.08,
             color: AppColors.kLight,
              text: "Login with a phone number",
              ),
        ],
      ),
    );
  }
}