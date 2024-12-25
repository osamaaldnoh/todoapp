import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';
import 'package:todoapp/res/widgets/custom_otn_btn.dart';
import 'package:todoapp/res/widgets/custom_text_feild.dart';
import 'package:todoapp/res/widgets/hieght_spacer.dart';
import 'package:todoapp/res/widgets/reusable_text.dart';
import 'package:todoapp/utils/routes/route_name.dart';

import '../../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
   LoginView({super.key});
  final LoginController loginController = Get.find();
  

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset('assets/images/todo.png',width: 300.w,
                ),
              ),
             const HieghtSpacer(height: 20),
             Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 16.w),
              child: ReusableText(
                text: 'Please enter your phone number',
                style: appStyle(
                  17,
                   AppColors.kLight,
                 FontWeight.w500
                 ),
              ),
             ),
             const HieghtSpacer(height: 20),
             Center(
              child: CustomTextFeild(
                controller: loginController.phoneController,
                prefixIcon: Container(
                  padding: EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        countryListTheme: CountryListThemeData(
                          backgroundColor: AppColors.kGreyLight,
                          bottomSheetHeight: SizeConfig.screenHeight*0.6,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppColors.kRadius),
                            topRight: Radius.circular(AppColors.kRadius),
                          )
                        ),
                       onSelect: (code) {
                         loginController.country.value =code;
                       },);
                    },
                    child: Obx(() => ReusableText(
                      text: '${loginController.country.value.flagEmoji} + ${loginController.country.value.phoneCode}',
                      style: appStyle(
                        18,
                         AppColors.kBkDark,
                          FontWeight.bold),
                    ),),
                  ),
                ),
                keyboardType: TextInputType.phone,
                hintText: 'Enter phone number',
                hintStyle: appStyle(
                  16,
                   AppColors.kBkDark,
                    FontWeight.w600),
              ),
             ),
             const HieghtSpacer(height: 20),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: CustomOtnlBtn(
                onTap: ()=>loginController.sendCodeToUser(context: context,
                phone: loginController.country.value.phoneCode),
                width: SizeConfig.screenWidth*0.9,
                height: SizeConfig.screenHeight*0.095,
                 color: AppColors.kBkDark,
                 color2: AppColors.kLight,
                  text: 'Send Code',
                  ),
             ),
            ],
          ),
          ),
          
          ),
    );
  }
}