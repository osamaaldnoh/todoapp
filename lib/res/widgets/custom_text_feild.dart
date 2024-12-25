import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoapp/res/appcolor.dart';
import 'package:todoapp/res/appstyle.dart';
import 'package:todoapp/res/size_config.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({super.key,
   this.keyboardType, 
   required this.hintText,
    this.suffixIcon, 
    this.prefixIcon, 
    this.hintStyle, 
    required this.controller, 
    this.onChanged});

  final TextInputType? keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      width: SizeConfig.screenWidth*0.9,
      height: SizeConfig.screenHeight*0.095,
      decoration: BoxDecoration(
        color: AppColors.kLight,
        borderRadius: BorderRadius.circular(AppColors.kRadius),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        cursorHeight: 25.h,
        onChanged: onChanged,
        style: appStyle(
          18,
         AppColors.kBkDark,
          FontWeight.w700),
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon, 
          suffixIconColor: AppColors.kBkDark,
          hintStyle: hintStyle, 
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.kRed,width: 0.5)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent,width: 0.5)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.kRed,width: 0.5)
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.kGreyDk,width: 0.5)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.kBkDark,width: 0.5)
          ),

        ),
      ),
    );
  }
}