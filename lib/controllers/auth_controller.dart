import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/data/auth/auth_repository.dart';

import '../data/auth/instance.dart';

class AuthController extends GetxController
{
  AuthRepository authRepository = AuthRepository();
   
  void verifyOtpCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
   })
   async{
    await authRepository.verifyOtp(context: context,
     smsCodeId: smsCodeId,
      smsCode: smsCode,
       mounted: mounted);
   }

   Future<void> sendSms({
    required BuildContext context,
    required String phone
   })
   async{
   await authRepository.sendOtp(context: context, phone: phone);
   }
}