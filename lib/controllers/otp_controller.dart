import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/auth_controller.dart';
import '../data/auth/instance.dart';

class OtpController extends GetxController
{
  RxString smsCodeId = "".obs;
  RxString phone = "".obs;
  RxBool showCursor = true.obs;

  final AuthController authController = Get.find(); 
  void verifyOtpCodeOtp({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
   })
   {
    authController.verifyOtpCode(context: context,
     smsCodeId: smsCodeId,
      smsCode: smsCode,
       mounted: mounted);
   }

}