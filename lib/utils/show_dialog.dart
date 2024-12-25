 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/widgets/reusable_text.dart';

showAlertDialoge({
  required BuildContext context,
  required String message,
  String? btnText,
 })
{
  return showDialog(context: context, builder: (context)
  {
    return AlertDialog(
      content: ReusableText(text: message,
      style: appStyle(18, AppColors.kLight, FontWeight.w600),
      ),
      contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      actions: [
        TextButton(onPressed: ()=>Get.back(),
         child: Text(btnText ?? "OK",
         style: appStyle(18, AppColors.kGreyLight, FontWeight.w500),
         ))
      ],
    );
  });
}