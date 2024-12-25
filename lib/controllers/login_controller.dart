import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/utils/show_dialog.dart';

import 'auth_controller.dart';

class LoginController extends GetxController
{
  final TextEditingController phoneController = TextEditingController();
  final AuthController authController = Get.find();
  


  // Country 
  var country = Country(
    phoneCode: '1',
    countryCode: 'US',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'USA',
    example: 'USA', 
    displayName: 'United States', 
    displayNameNoCountryCode: 'US',
    e164Key: ''
  ).obs; 


  sendCodeToUser({required BuildContext context,required String phone})
  async{
    if(phoneController.text.isEmpty)
    {
      return showAlertDialoge(context: context, message: 'Please enter your phone number',);
    }
    else if(phoneController.text.length < 8)
    {
      return showAlertDialoge(context: context, message: 'Your number is too short',);
    }
    else
    {
      print("+${phone} ${phoneController.text}");
      await authController.sendSms(context: context, 
      phone: "+$phone${phoneController.text}");
    }
  }
}