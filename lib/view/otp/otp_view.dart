import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:todoapp/controllers/otp_controller.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';
import 'package:todoapp/res/widgets/hieght_spacer.dart';
import 'package:todoapp/res/widgets/reusable_text.dart';
import 'package:todoapp/utils/routes/route_name.dart';

class OtpView extends StatelessWidget {
   OtpView({super.key});
    OtpController otpController = Get.find();
   
  @override
  Widget build(BuildContext context) {
    otpController.phone.value = Get.arguments['phone'];
    otpController.smsCodeId.value = Get.arguments['smsCodeId'];
    
    print(otpController.smsCodeId.value);
    print(otpController.phone.value);
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HieghtSpacer(height: SizeConfig.screenHeight * 0.10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  'assets/images/todo.png',
                  width: SizeConfig.screenWidth * 0.5,
                ),
              ),
              const HieghtSpacer(height: 26),
              ReusableText(
                text: 'Enter your otp code',
                style: appStyle(18, AppColors.kLight, FontWeight.bold),
              ),
              const HieghtSpacer(height: 26),
              
                Obx(() =>
                Pinput(
                length: 6,
                showCursor: otpController.showCursor.value,
                 androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                onCompleted: (value) {
                  if (value.length == 6) 
                  {
                    print("vvvvvvvvvvvvvvvvv:$value");
                    return otpController.verifyOtpCodeOtp(
                      context: context, 
                    smsCodeId: otpController.smsCodeId.value, 
                    smsCode: value, 
                    mounted: true);
                  }
                  
                },
                onSubmitted: (value) {
                  if (value.length == 6) 
                  {
                    return otpController.verifyOtpCodeOtp(context: context, 
                    smsCodeId: otpController.smsCodeId.value, 
                    smsCode: value, 
                    mounted: true);
                  }
                },
                
              ),
                )
            ],
          ),
        ),
      )),
    );
  }
}
